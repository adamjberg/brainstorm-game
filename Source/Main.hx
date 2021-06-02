package;

import openfl.events.MouseEvent;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

import openfl.events.Event;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.text.AntiAliasType;
import openfl.display.Sprite;

class Main extends Sprite {
	private var cloudContainer: Sprite;
	private var clouds:Array<Cloud> = [];
	private var nextCloudTimeMs:Float;
	private var thoughtPool = [
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought(""),
		new Thought("Randomness sometimes clumps too much"),
		new Thought("Add score tracking", "task"),
		new Thought("Add red background flash when cloud hits bottom", "task"),
		new Thought("Add ability to categorize thoughts", "task"),
		new Thought("How many are needed in one level?"),
		new Thought("Will this work?"),
		new Thought("How should I structure thoughts?"),
		new Thought("How do I trickle them down?"),
		new Thought("Sometimes I miss making games")
	];
	private var txtThought: TextField;

	public function new() {
		super();

		cloudContainer = new Sprite();
		addChild(cloudContainer);

		nextCloudTimeMs = getTime();

		addEventListener(Event.ENTER_FRAME, handleEnterFrame);

		var engramBlue = 0x3f51b5;
		var dpiScale = stage.window.scale;

		var headerBG = new Sprite();
		headerBG.graphics.beginFill(engramBlue);
		headerBG.graphics.drawRect(0, 0, stage.stageWidth, 64 * dpiScale);
		headerBG.graphics.endFill();
		addChild(headerBG);

		var logoSprite = new Sprite();
		BitmapData.loadFromFile ("Assets/logo512.png").onComplete (function (bitmapData) {
			trace("loaded");
			var bitmap = new Bitmap (bitmapData);
			var logoSize = Math.round(headerBG.height * 0.8);
			var padding = (headerBG.height - logoSize) * 0.5;
			bitmap.x = stage.stageWidth - logoSize - padding;
			bitmap.y = padding;
			bitmap.width = logoSize;
			bitmap.height = logoSize;
			logoSprite.addChild (bitmap);
			
		});
		addChild(logoSprite);

		var bottomNav = new Sprite();
		var bottomNavHeight = (56 + 64) * dpiScale;
		bottomNav.y = stage.stageHeight - bottomNavHeight;

		var bottomNavBG = new Sprite();
		bottomNavBG.graphics.beginFill(0x424242);
		bottomNavBG.graphics.drawRect(0, 0, stage.stageWidth, bottomNavHeight);
		bottomNavBG.graphics.endFill();
		bottomNav.addChild(bottomNavBG);

		var textEntryContainer = new Sprite();

		var yPadding = 8 * dpiScale;
		var contentWidth = Math.round(stage.stageWidth * 0.8);

		txtThought = new TextField();
		txtThought.selectable = false;
		txtThought.width = contentWidth;
		txtThought.x = (stage.stageWidth - txtThought.width) * 0.5;
		txtThought.y = yPadding;

		textEntryContainer.addChild(txtThought);

		var textBoxUnderline = new Sprite();
		textBoxUnderline.graphics.beginFill(engramBlue);
		textBoxUnderline.graphics.drawRect(txtThought.x, 32 * dpiScale + yPadding, txtThought.width, 2 * dpiScale);
		textBoxUnderline.graphics.endFill();

		textEntryContainer.addChild(textBoxUnderline);

		bottomNav.addChild(textEntryContainer);

		var tabsContainer = new Sprite();
		tabsContainer.x = (stage.stageWidth - contentWidth) * 0.5;
		tabsContainer.y = 64 * dpiScale;

		var tfTab = new TextFormat();
		tfTab.color = 0xffffff;
		tfTab.font = "Helvetica";
		tfTab.size = Math.round(16 * dpiScale);

		var noteTab = new Sprite();

		var noteTabIcon = new Sprite();
		noteTabIcon.graphics.beginFill(0xFFFFFF);
		noteTabIcon.graphics.drawRect(0, 0, 8 * dpiScale, 2 * dpiScale);
		noteTabIcon.graphics.endFill();
		noteTabIcon.x = -noteTabIcon.width * 0.5;

		noteTab.addChild(noteTabIcon);

		var txtNote = new TextField();
		txtNote.text = "Notes";
		txtNote.setTextFormat(tfTab);
		txtNote.x = -txtNote.textWidth * 0.5;
		txtNote.y = yPadding;
		noteTab.addChild(txtNote);

		var taskTab = new Sprite();

		var taskTabIcon = new Sprite();
		taskTabIcon.graphics.beginFill(0xFFFFFF);
		taskTabIcon.graphics.drawCircle(0, 0, 4 * dpiScale);
		taskTabIcon.graphics.endFill();

		var txtTask = new TextField();
		txtTask.text = "Tasks";
		txtTask.setTextFormat(tfTab);
		txtTask.x = -txtTask.textWidth * 0.5;
		txtTask.y = yPadding;

		taskTab.addChild(txtTask);
		taskTab.addChild(taskTabIcon);

		var eventTab = new Sprite();

		var eventTabIcon = new Sprite();
		eventTabIcon.graphics.lineStyle(2, 0xFFFFFF);
		eventTabIcon.graphics.drawCircle(0, 0, 4 * dpiScale);
		eventTabIcon.graphics.endFill();

		eventTab.addChild(eventTabIcon);

		var txtEvent = new TextField();
		txtEvent.text = "Events";
		txtEvent.setTextFormat(tfTab);
		txtEvent.x = -txtEvent.textWidth * 0.5;
		txtEvent.y = yPadding;

		eventTab.addChild(txtEvent);

		noteTab.x = noteTab.width * 0.5;
		taskTab.x = contentWidth * 0.5;
		eventTab.x = contentWidth - (eventTab.width * 0.5);

		tabsContainer.addChild(noteTab);
		tabsContainer.addChild(taskTab);
		tabsContainer.addChild(eventTab);

		tabsContainer.y = 72 * dpiScale;

		bottomNav.addChild(tabsContainer);

		addChild(bottomNav);
	}

	private function addThought() {
		if (thoughtPool.length > 0) {
			var currentThought = thoughtPool.pop();
			var cloud = new Cloud(currentThought);
			var left = Math.round(stage.stageWidth * 0.2) + cloud.width;
			var right = Math.round(stage.stageWidth * 0.8) - cloud.width;
			var range = right - left;
			cloud.x = Math.round(left + (Math.random() * range));
			cloud.addEventListener(MouseEvent.CLICK, handleCloudClicked);
			clouds.push(cloud);

			cloudContainer.addChild(cloud);

			nextCloudTimeMs = getTime() + Math.random() * 4000;
		} else {
			nextCloudTimeMs = Math.NaN;
		}
	}

	private function handleCloudClicked(e: MouseEvent) {
		var cloud: Cloud = e.target;
		txtThought.text = cloud.thought.body;
		var tf = new TextFormat();
		tf.color = 0xffffff;
		tf.font = "Helvetica";
		var dpiScale = stage.window.scale;
		tf.size = Math.round(24 * dpiScale);
		txtThought.setTextFormat(tf);
	}

	private function handleEnterFrame(e:Event) {
		if (getTime() > nextCloudTimeMs) {
			addThought();
		}

		for (cloud in clouds) {
			cloud.y += 1;
		}
	}

	private function getTime() {
		return Date.now().getTime();
	}
}