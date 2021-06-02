package;

import openfl.events.MouseEvent;
import openfl.filters.DropShadowFilter;
import openfl.filters.GlowFilter;
import openfl.display.Shape;
import openfl.display.Sprite;

class Cloud extends Sprite {
	public var thought: Thought;

	public function new(thought: Thought) {
		super();

		this.thought = thought;

		buttonMode = true;
		useHandCursor = true;

		var height = 100;
		var width = 150;
		var unitSize = height / 8;

		var cloudBG = new Shape();

		cloudBG.graphics.lineStyle(2, 0);
		cloudBG.graphics.beginFill(0xFFFFFF);
		cloudBG.graphics.moveTo(unitSize * 2, unitSize * 4);
		cloudBG.graphics.lineTo(-unitSize * 2, unitSize * 4);
		cloudBG.graphics.cubicCurveTo(-unitSize * 10, unitSize * 4.5, -unitSize * 8, -unitSize, -unitSize * 4, unitSize);
		cloudBG.graphics.cubicCurveTo(-unitSize * 8, -unitSize * 3, -unitSize * 0, -unitSize * 3, -unitSize, -unitSize);
		cloudBG.graphics.cubicCurveTo(0, -unitSize * 8, unitSize * 8, 0, unitSize * 4, 0);
		cloudBG.graphics.cubicCurveTo(unitSize * 8, 0, unitSize * 8, unitSize * 4, unitSize * 2, unitSize * 4);

    applyDropShadow();

		addChild(cloudBG);

		addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
    addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
    addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
    addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
	}

	private function handleMouseOver(e: MouseEvent) {
		applyGlowFilter();
	}

  private function handleMouseOut(e: MouseEvent) {
		applyDropShadow();
	}

  private  function applyGlowFilter() {
    var blur = 6 * stage.window.scale;
    var glowFilter = new GlowFilter(Colors.ENGRAM_BLUE, 1, blur, blur, 4);
    filters = [glowFilter];
  }

  private function applyDropShadow() {
    filters = [new DropShadowFilter()];
  }

  private function handleMouseDown(e: MouseEvent) {
    scaleX = scaleY = 0.9;
  }

  private function handleMouseUp(e: MouseEvent) {
    scaleX = scaleY = 1;
  }
}