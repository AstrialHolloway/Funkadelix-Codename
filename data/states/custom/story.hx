package funkin.menus;

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

var menuBG:FlxSprite = null;

// Week names must match XML `name` attributes
var weekOptions:Array<String> = ["week0", "week1", "week2", "week3"];
var weekDiffs:Array<String> = ["easy", "normal", "hard"];

var weekList:Array<Dynamic> = 
[
    {
        "name": "Week0",
        "songs": [{"name": "tutorial-funk"}],
        "id": 0
    },
    {
        "name": "Week1",
        "songs": [{"name": "bopeebo-funk"}, {"name": "fresh-funk"}, {"name": "dad-battle-funk"}],
        "id": 1
    },
    {
        "name": "Week2",
        "songs": [{"name": "spookeez-funk"}, {"name": "south-funk"}],
        "id": 2
    },
    {
        "name": "Week3",
        "songs": [{"name": "philly-nice-funk"}],
        "id": 3
    }
];

// Week menu images for previews
var weekSongList:Array<String> = [
    "menus/story/week 0",
    "menus/story/week 1",
    "menus/story/week 2",
    "menus/story/week 3"
];

var curIndex:Int = 0;       // start on week0
var curDiffIndex:Int = 1;   // start on normal difficulty

// -------------------------
// Sprites
// -------------------------
var backgroundSprite:FunkinSprite = new FunkinSprite(0, 0);
backgroundSprite.loadGraphic(Paths.image("menus/grad"));
add(backgroundSprite);

// -------------------------
// Moving Tiles (layered above background)
// -------------------------
var tileSprites:Array<FunkinSprite> = [];
var tileSize:Int = 114;
var screenWidth:Float = FlxG.width;
var screenHeight:Float = FlxG.height;

// Speed in pixels/sec
var tileMoveSpeedX:Float = 10; // pixels/sec to the left
var tileMoveSpeedY:Float = 10; // pixels/sec downward

for (x in 0...Math.ceil(screenWidth / tileSize) + 1)
{
    for (y in 0...Math.ceil(screenHeight / tileSize) + 1)
    {
        var tile:FunkinSprite = new FunkinSprite(x * tileSize, y * tileSize);
        tile.loadGraphic(Paths.image("menus/tile"));
        add(tile);
        tileSprites.push(tile);
    }
}

// -------------------------
// Other sprites
// -------------------------
var discSprite:FunkinSprite = new FunkinSprite(810, 413.5);
discSprite.frames = Paths.getSparrowAtlas("menus/story/disc");
discSprite.animation.addByPrefix("disc", "disc", 24, true);
discSprite.animation.play("disc");
add(discSprite);

var borderSprite:FunkinSprite = new FunkinSprite(-40,-35);
borderSprite.loadGraphic(Paths.image("menus/story/border"));
add(borderSprite);

var cornerSprite:FunkinSprite = new FunkinSprite(860,-27.5);
cornerSprite.loadGraphic(Paths.image("menus/story/corner"));
add(cornerSprite);

// Week selection sprites
var week0Sprite:FunkinSprite = new FunkinSprite(20, 31.5);
week0Sprite.frames = Paths.getSparrowAtlas("menus/story/selections/week0");
week0Sprite.animation.addByPrefix("basic", "basic", 24, true);
week0Sprite.animation.addByPrefix("sel", "sel", 24, true);
week0Sprite.animation.play("sel");
add(week0Sprite);

var week1Sprite:FunkinSprite = new FunkinSprite(50, 168);
week1Sprite.frames = Paths.getSparrowAtlas("menus/story/selections/week1");
week1Sprite.animation.addByPrefix("basic", "basic", 24, true);
week1Sprite.animation.addByPrefix("sel", "sel", 24, true);
week1Sprite.animation.play("basic");
add(week1Sprite);

var week2Sprite:FunkinSprite = new FunkinSprite(50, 300.5);
week2Sprite.frames = Paths.getSparrowAtlas("menus/story/selections/week2");
week2Sprite.animation.addByPrefix("basic", "basic", 24, true);
week2Sprite.animation.addByPrefix("sel", "sel", 24, true);
week2Sprite.animation.play("basic");
add(week2Sprite);

var week3Sprite:FunkinSprite = new FunkinSprite(50, 433);
week3Sprite.frames = Paths.getSparrowAtlas("menus/story/selections/week3");
week3Sprite.animation.addByPrefix("basic", "basic", 24, true);
week3Sprite.animation.addByPrefix("sel", "sel", 24, true);
week3Sprite.animation.play("basic");
add(week3Sprite);

// Difficulty arrows/icons
var diffLeftSprite:FunkinSprite = new FunkinSprite(-114, 575);
diffLeftSprite.frames = Paths.getSparrowAtlas("menus/story/difficulty");
diffLeftSprite.animation.addByPrefix("easy", "earrow", 24, true);
diffLeftSprite.animation.addByPrefix("normal", "narrow", 24, true);
diffLeftSprite.animation.addByPrefix("hard", "harrow", 24, true);
diffLeftSprite.animation.play("normal");
diffLeftSprite.origin.set(diffLeftSprite.width / 2, diffLeftSprite.height / 2);
diffLeftSprite.scale.x = -1;
add(diffLeftSprite);

var diffRightSprite:FunkinSprite = new FunkinSprite(383.5, 574);
diffRightSprite.frames = Paths.getSparrowAtlas("menus/story/difficulty");
diffRightSprite.animation.addByPrefix("easy", "earrow", 24, true);
diffRightSprite.animation.addByPrefix("normal", "narrow", 24, true);
diffRightSprite.animation.addByPrefix("hard", "harrow", 24, true);
diffRightSprite.animation.play("normal");
add(diffRightSprite);

var diffSprite:FunkinSprite = new FunkinSprite(108.5, 575);
diffSprite.frames = Paths.getSparrowAtlas("menus/story/difficulty");
diffSprite.animation.addByPrefix("easy", "easy", 24, true);
diffSprite.animation.addByPrefix("normal", "normal", 24, true);
diffSprite.animation.addByPrefix("hard", "hard", 24, true);
diffSprite.animation.play("normal");
add(diffSprite);

// Song preview
var songsSprite:FunkinSprite = new FunkinSprite(800, 372);
songsSprite.loadGraphic(Paths.image(weekSongList[curIndex]));
add(songsSprite);

// -------------------------
// Create / Update
// -------------------------
function create()
{
    trace("Story Menu Loaded");
}

function update(elapsed:Float)
{
    CoolUtil.playMenuSong();

    // -------------------------
    // Move tiles
    // -------------------------
    for(tile in tileSprites)
    {
        tile.x -= tileMoveSpeedX * elapsed;
        tile.y += tileMoveSpeedY * elapsed;

        if(tile.x + tile.width < 0)
            tile.x += Math.ceil(screenWidth / tile.width + 1) * tile.width;

        if(tile.y > screenHeight)
            tile.y -= Math.ceil(screenHeight / tile.height + 1) * tile.height;
    }

    

    // -------------------------
    // Update week sprites
    // -------------------------
    week0Sprite.animation.play(if(curIndex == 0) "sel" else "basic");
    week1Sprite.animation.play(if(curIndex == 1) "sel" else "basic");
    week2Sprite.animation.play(if(curIndex == 2) "sel" else "basic");
    week3Sprite.animation.play(if(curIndex == 3) "sel" else "basic");

    // Update song preview
    songsSprite.loadGraphic(Paths.image(weekSongList[curIndex]));

    // Update difficulty sprites
    diffSprite.animation.play(weekDiffs[curDiffIndex]);
    diffLeftSprite.animation.play(weekDiffs[curDiffIndex]);
    diffRightSprite.animation.play(weekDiffs[curDiffIndex]);

    // -------------------------
    // Enter: load week
    // -------------------------
    
}

function handleInputs()
{
    if(controls.ACCEPT)
    {
        FlxG.sound.play(Paths.sound("menu/confirm"));

        var weekName:String = weekOptions[curIndex];
        var difficulty:String = weekDiffs[curDiffIndex];

        trace("Attempting to load week: " + weekName + " on difficulty: " + difficulty);

        PlayState.loadWeek(weekList[curIndex], weekDiffs[curDiffIndex]);
        FlxG.switchState(new PlayState());
    }
    
    if(controls.BACK)
        FlxG.switchState(new MainMenuState());

    // -------------------------
    // Week selection
    // -------------------------
    if(controls.DOWN_P)
    {
        curIndex++;
        if(curIndex >= weekOptions.length) curIndex = 0;
        FlxG.sound.play(Paths.sound("menu/scroll"));
    }
    if(controls.UP_P)
    {
        curIndex--;
        if(curIndex < 0) curIndex = weekOptions.length - 1;
        FlxG.sound.play(Paths.sound("menu/scroll"));
    }

    // -------------------------
    // Difficulty selection
    // -------------------------
    if(controls.RIGHT_P)
    {
        curDiffIndex++;
        if(curDiffIndex >= weekDiffs.length) curDiffIndex = 0;
        FlxG.sound.play(Paths.sound("menu/scroll"));
    }
    if(controls.LEFT_P)
    {
        curDiffIndex--;
        if(curDiffIndex < 0) curDiffIndex = weekDiffs.length - 1;
        FlxG.sound.play(Paths.sound("menu/scroll"));
    }
    
}
