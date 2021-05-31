package;


import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.text.AntiAliasType;
import openfl.display.Sprite;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();

		var engramBlue = 0x3f51b5;
		var dpiScale = stage.window.scale;

		var headerBG = new Sprite();
		headerBG.graphics.beginFill(engramBlue);
		headerBG.graphics.drawRect(0, 0, stage.stageWidth, 64 * dpiScale);
		headerBG.graphics.endFill();
		addChild(headerBG);

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
			
		var textBox = new TextField();
		textBox.selectable = false;
		textBox.text = "This is where the thought will be populated when clicked";
		textBox.antiAliasType = AntiAliasType.ADVANCED;
		var tf = new TextFormat();
		tf.color = 0xffffff;
		tf.font = "Helvetica";
		tf.size = Math.round(24 * dpiScale);
		textBox.setTextFormat(tf);
		textBox.height = 32 * dpiScale;
		textBox.width = contentWidth;
		textBox.x = (stage.stageWidth - textBox.width) * 0.5;
		textBox.y = yPadding;

		textEntryContainer.addChild(textBox);

		var textBoxUnderline = new Sprite();
		textBoxUnderline.graphics.beginFill(engramBlue);
		textBoxUnderline.graphics.drawRect(textBox.x, textBox.height + yPadding, textBox.width, 2 * dpiScale);
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
	
	
}