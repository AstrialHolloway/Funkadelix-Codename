import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.typeLimit.OneOfTwo;
import funkin.backend.FunkinText;
import funkin.backend.scripting.events.CancellableEvent;
import funkin.backend.scripting.events.menu.MenuChangeEvent;

import funkin.savedata.FunkinSave;
import haxe.io.Path;
import haxe.xml.Access;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;
import funkin.game.PlayState;

var lyricsText:FlxText = null;
var lyricsOutline:Array<FlxText> = [];

function onEvent(lyrics) {
  if (lyrics.event.name == "lyrics-second-line-simple") {
    
    var params:Array = lyrics.event.params;
    var textColor:String = "#ffffff";
    var fontSize:Int = 20; // smaller font size
    var textY:Int = 535;   // position on screen

    if (params[1] == "bf") textColor = "#17ffaa";
    if (params[1] == "gf") textColor = "#a5004d";
    if (params[1] == "dad") textColor = "#af66ce";
    if (params[1] == "skid") textColor = "#b4b4b4";
    if (params[1] == "pump") textColor = "#d57e00";
    if (params[1] == "monster") textColor = "#f3ff6e";
    if (params[1] == "pico") textColor = "#fc502f";

    if (params[0] == "") {
        trace("LYRICS LINE 2:");
        trace("Lyrics Line 2 Cleared");
        trace("");
    } else {
        if (params[1] == "") {
            trace("LYRICS LINE 2:");
            trace("Someone just sung \"" + params[0] + "\" on the second line");
            trace("");
        } else {
            trace("LYRICS LINE 2:");
            trace(params[1] + " just sung \"" + params[0] + "\" on the second line");
            trace("");
        }
    }

    // Outline thickness scales with font size
    var outlineSize:Int = Math.ceil(fontSize / 10);
    var textWidth:Int = FlxG.width;

    if (lyricsText == null) {
      // make fake outline (black text around main)
      var offsets = [
        {x: -outlineSize, y: 0}, {x: outlineSize, y: 0},
        {x: 0, y: -outlineSize}, {x: 0, y: outlineSize},
        {x: -outlineSize, y: -outlineSize}, {x: outlineSize, y: -outlineSize},
        {x: -outlineSize, y: outlineSize}, {x: outlineSize, y: outlineSize}
      ];

      for (offset in offsets) {
        var outline = new FlxText(offset.x, textY + offset.y, textWidth, params[0]);
        outline.setFormat("fonts/lyrics.otf", fontSize, 0xFF000000, "center");
        outline.scrollFactor.set(0, 0);
        lyricsOutline.push(outline);
        add(outline);
      }

      // main colored text
      lyricsText = new FlxText(0, textY, textWidth, params[0]);
      lyricsText.setFormat("fonts/lyrics.otf", fontSize, Std.parseInt("0x" + textColor.substr(1)), "center");
      lyricsText.scrollFactor.set(0, 0);
      add(lyricsText);

    } else {
      // update outlines
      for (outline in lyricsOutline) {
        outline.text = params[0];
      }

      // update main
      lyricsText.text = params[0];
      lyricsText.color = Std.parseInt("0x" + textColor.substr(1));
    }
  }
}
