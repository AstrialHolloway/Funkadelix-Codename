// Script by AstroDev, if modifying please have a basic understanding of haxe!

// Scroll speed (pixels per frame)
var scrollSpeed:Float = 0.2; // adjust for smoothness

var index = 0;
var diff = 0;

var songList:Array<String> = 
[
    "tutorial", 
    "bopeebo", 
    "fresh", 
    "dad-battle", 
    "spookeez", 
    "south", 
    "philly-nice",
    "monster",
    "pico",
    "themesong",
    "leaked",
    "philly-nice-test"
];

var songDisplayList:Array<String> = 
[
    "TUTORIAL", 
    "BOPEEBO", 
    "FRESH", 
    "DAD BATTLE", 
    "SPOOKEEZ", 
    "SOUTH", 
    "PHILLY NICE",
    "MONSTER",
    "PICO",
    "THEME SONG",
    "LEAKED",
    "TESTING"
];

var weekList:Array<String> =
[
    "menus/free/tutorial",
    "menus/free/week 1",
    "menus/free/week 1",
    "menus/free/week 1",
    "menus/free/week 2",
    "menus/free/week 2",
    "menus/free/week 3",
    "menus/free/week 2",
    "menus/free/week 3",
    "menus/free/tutorial",
    "menus/free/tutorial",
    "menus/free/tutorial"
];

var bpmList:Array<String> = 
[
    100, 
    100, 
    120, 
    180, 
    150, 
    170, 
    175,
    118,
    150,
    150,
    100,
    175
];

var diffList:Array<String> = ["normal", "hard", "easy"];

var iconSprite:FunkinSprite;

// -------------------------
// Background
// -------------------------
var backgroundSprite:FunkinSprite = new FunkinSprite(0, 0);
backgroundSprite.loadGraphic(Paths.image("menus/grad"));
add(backgroundSprite);

// -------------------------
// Moving tile background (layered above backgroundSprite)
// -------------------------
var tileSprites:Array<FunkinSprite> = [];
var tileSize:Int = 114; // size of each tile sprite
var screenWidth:Float = FlxG.width;
var screenHeight:Float = FlxG.height;

// Fill the screen with tiles
for(x in 0...Math.ceil(screenWidth / tileSize) + 1)
{
    for(y in 0...Math.ceil(screenHeight / tileSize) + 1)
    {
        var tile:FunkinSprite = new FunkinSprite(x * tileSize, y * tileSize);
        tile.loadGraphic(Paths.image("menus/tile"));
        add(tile);
        tileSprites.push(tile);
    }
}

// Movement speed (pixels per second)
var tileMoveSpeedX:Float = 10; // move left
var tileMoveSpeedY:Float = 10; // move down

// -------------------------
// Other Sprites
// -------------------------
var freeplayText1Sprite:FunkinSprite = new FunkinSprite(835, 10);
freeplayText1Sprite.loadGraphic(Paths.image("menus/free/freeplayText"));
add(freeplayText1Sprite);

var freeplayText2Sprite:FunkinSprite = new FunkinSprite(835, freeplayText1Sprite.height + 50);
freeplayText2Sprite.loadGraphic(Paths.image("menus/free/freeplayText"));
add(freeplayText2Sprite);

var backingSprite:FunkinSprite = new FunkinSprite(380, 500);
backingSprite.loadGraphic(Paths.image("menus/free/backing"));
backingSprite.scale.set(3, 5);
add(backingSprite);

var borderSprite:FunkinSprite = new FunkinSprite(-24.5, -48.5);
borderSprite.loadGraphic(Paths.image("menus/free/border"));
add(borderSprite);

var trackSprite:FunkinSprite = new FunkinSprite(981, 39.2);
trackSprite.loadGraphic(Paths.image("menus/free/track"));
add(trackSprite);

var boxSprite:FunkinSprite = new FunkinSprite(128, 44);
boxSprite.loadGraphic(Paths.image("menus/free/box"));
add(boxSprite);

var BANNERSprite:FunkinSprite = new FunkinSprite(232.6, 172);
BANNERSprite.loadGraphic(Paths.image("menus/free/BANNER"));
add(BANNERSprite);

var discSprite:FunkinSprite = new FunkinSprite(334.5, 261.5);
discSprite.frames = Paths.getSparrowAtlas("menus/free/disc");
discSprite.animation.addByPrefix("Symbol 2", "Symbol 2", 24, true);
discSprite.animation.play("Symbol 2");
discSprite.scale.set(0.8, 0.8);
add(discSprite);

var easyDiffSprite:FunkinSprite = new FunkinSprite(1223, 378);
easyDiffSprite.loadGraphic(Paths.image("menus/free/easy"));
add(easyDiffSprite);

var normalDiffSprite:FunkinSprite = new FunkinSprite(1009, 457);
normalDiffSprite.loadGraphic(Paths.image("menus/free/normal"));
add(normalDiffSprite);

var hardDiffSprite:FunkinSprite = new FunkinSprite(1223, 536);
hardDiffSprite.loadGraphic(Paths.image("menus/free/hard"));
add(hardDiffSprite);

var thingyDark1Sprite:FunkinSprite = new FunkinSprite(269.5, 408);
thingyDark1Sprite.loadGraphic(Paths.image("menus/free/thingy2"));
add(thingyDark1Sprite);

var thingyDark2Sprite:FunkinSprite = new FunkinSprite(537.5, 408);
thingyDark2Sprite.loadGraphic(Paths.image("menus/free/thingy2"));
add(thingyDark2Sprite);

var thingySprite:FunkinSprite = new FunkinSprite(403.5, 408);
thingySprite.loadGraphic(Paths.image("menus/free/thingy"));
add(thingySprite);

// -------------------------
// Text
// -------------------------
var textColor:String = "#000000";

middleSongText = new FlxText(402, 425, 130, songDisplayList[index], 10);
middleSongText.setFormat("fonts/freeplay.otf", 20, Std.parseInt("0x" + textColor.substr(1)), "center");
add(middleSongText);

middleBPMText = new FlxText(402, 490, 130, "BPM: " + bpmList[index], 10);
middleBPMText.setFormat("fonts/freeplay.otf", 15, Std.parseInt("0x" + textColor.substr(1)), "center");
add(middleBPMText);

rightSongText = new FlxText(533, 425, 130, songDisplayList[index + 1], 10);
rightSongText.setFormat("fonts/freeplay.otf", 20, Std.parseInt("0x" + textColor.substr(1)), "center");
add(rightSongText);

rightBPMText = new FlxText(533, 490, 130, "BPM: " + bpmList[index + 1], 10);
rightBPMText.setFormat("fonts/freeplay.otf", 15, Std.parseInt("0x" + textColor.substr(1)), "center");
add(rightBPMText);

leftSongText = new FlxText(266, 425, 130, songDisplayList[11], 10);
leftSongText.setFormat("fonts/freeplay.otf", 20, Std.parseInt("0x" + textColor.substr(1)), "center");
add(leftSongText);

leftBPMText = new FlxText(266, 490, 130, "BPM: " + bpmList[11], 10);
leftBPMText.setFormat("fonts/freeplay.otf", 15, Std.parseInt("0x" + textColor.substr(1)), "center");
add(leftBPMText);

var arrow1Sprite:FunkinSprite = new FunkinSprite(671.5, 437);
arrow1Sprite.loadGraphic(Paths.image("menus/free/arrow"));
add(arrow1Sprite);

var arrow2Sprite:FunkinSprite = new FunkinSprite(209.5, 437); 
arrow2Sprite.loadGraphic(Paths.image("menus/free/arrow"));
arrow2Sprite.origin.set(arrow2Sprite.width / 2, arrow2Sprite.height / 2);
arrow2Sprite.scale.x = -1;
add(arrow2Sprite);

var textColor2:String = "#148991"; 

devText = new FlxText(20, 20, 200, "DEVELOPER MODE", 10);
devText.setFormat("fonts/freeplay.otf", 25, Std.parseInt("0x" + textColor2.substr(1)), "center");
add(devText);

// -------------------------
// Create function
// -------------------------
function create()
{
    trace("Freeplay Dev Mode Loaded");

    weekSprite = new FunkinSprite(369.6,200.7);
    weekSprite.loadGraphic(Paths.image(weekList[index]));
    add(weekSprite);

    trace("week added");
}

// -------------------------
// Update function
// -------------------------
function update()
{
    CoolUtil.playMenuSong();

    weekSprite.loadGraphic(Paths.image(weekList[index]));

    // --- Move the tiles ---
    for(tile in tileSprites)
    {
        tile.x -= tileMoveSpeedX * FlxG.elapsed;
        tile.y += tileMoveSpeedY * FlxG.elapsed;

        // Wrap horizontally
        if(tile.x + tile.width < 0)
            tile.x += Math.ceil(screenWidth / tile.width + 1) * tile.width;

        // Wrap vertically
        if(tile.y > screenHeight)
            tile.y -= Math.ceil(screenHeight / tile.height + 1) * tile.height;
    }

    freeplayText1Sprite.y -= scrollSpeed; 
    freeplayText2Sprite.y -= scrollSpeed;

    if (freeplayText1Sprite.y <= -freeplayText1Sprite.height - 50)
        freeplayText1Sprite.y = freeplayText2Sprite.height + 50; 

    if (freeplayText2Sprite.y <= -freeplayText1Sprite.height - 50)
        freeplayText2Sprite.y = freeplayText1Sprite.height + 50; 

    // Difficulty layering + smooth slower movement
    if(diff == 0)
    {
        remove(normalDiffSprite, true);
        add(normalDiffSprite);

        normalDiffSprite.x = FlxMath.lerp(normalDiffSprite.x, 1009, 0.09);
        hardDiffSprite.x = FlxMath.lerp(hardDiffSprite.x, 1223, 0.09);
        easyDiffSprite.x = FlxMath.lerp(easyDiffSprite.x, 1223, 0.09);
    }
    else if(diff == 1)
    {
        remove(hardDiffSprite, true);
        add(hardDiffSprite);

        hardDiffSprite.x = FlxMath.lerp(hardDiffSprite.x, 1009, 0.09);
        normalDiffSprite.x = FlxMath.lerp(normalDiffSprite.x, 1223, 0.09);
        easyDiffSprite.x = FlxMath.lerp(easyDiffSprite.x, 1223, 0.09);
    }
    else if(diff == 2)
    {
        remove(easyDiffSprite, true);
        add(easyDiffSprite);

        easyDiffSprite.x = FlxMath.lerp(easyDiffSprite.x, 1009, 0.09);
        normalDiffSprite.x = FlxMath.lerp(normalDiffSprite.x, 1223, 0.09);
        hardDiffSprite.x = FlxMath.lerp(hardDiffSprite.x, 1223, 0.09);
    }

    handleInputs();
}

// -------------------------
// Inputs
// -------------------------
function handleInputs()
{
    if (FlxG.keys.justPressed.LEFT)
    {
        index--;
        FlxG.sound.play(Paths.sound("menu/scroll"), 0.7);

        middleSongText.text = songDisplayList[index];
        middleBPMText.text = "BPM: " + bpmList[index];

        rightSongText.text = songDisplayList[index + 1];
        rightBPMText.text = "BPM: " + bpmList[index + 1];

        leftSongText.text = songDisplayList[index - 1];
        leftBPMText.text = "BPM: " + bpmList[index -  1];

        if (index < 0)
        {
            index = 11;
            middleSongText.text = songDisplayList[index];
            middleBPMText.text = "BPM: " + bpmList[index];

            rightSongText.text = songDisplayList[0];
            rightBPMText.text = "BPM: " + bpmList[0];

            leftSongText.text = songDisplayList[index - 1];
            leftBPMText.text = "BPM: " + bpmList[index - 1];
        }

        if (index == 0)
        {
            leftSongText.text = songDisplayList[11];
            leftBPMText.text = "BPM: " + bpmList[11];
        }

        trace("song changed to: " + songList[index]);
        trace("BPM changed to: " + bpmList[index]);
    }

    if (FlxG.keys.justPressed.RIGHT)
    {
        index++;
        FlxG.sound.play(Paths.sound("menu/scroll"), 0.7);

        middleSongText.text = songDisplayList[index];
        middleBPMText.text = "BPM: " + bpmList[index];

        rightSongText.text = songDisplayList[index + 1];
        rightBPMText.text = "BPM: " + bpmList[index + 1];

        leftSongText.text = songDisplayList[index - 1];
        leftBPMText.text = "BPM: " + bpmList[index -  1];

        if (index == 12)
        {
            index = 0;
            middleSongText.text = songDisplayList[index];
            middleBPMText.text = "BPM: " + bpmList[index];

            rightSongText.text = songDisplayList[index + 1];
            rightBPMText.text = "BPM: " + bpmList[index + 1];

            leftSongText.text = songDisplayList[11];
            leftBPMText.text = "BPM: " + bpmList[11];
        }

        if (index == 11)
        {
            rightSongText.text = songDisplayList[0];
            rightBPMText.text = "BPM: " + bpmList[0];
        }

        trace("song changed to: " + songList[index]);
        trace("BPM changed to: " + bpmList[index]);
    }

    if (FlxG.keys.justPressed.UP)
    {
        diff--;
        FlxG.sound.play(Paths.sound("menu/scroll"), 0.7);

        if (diff < 0) diff = 2;
        trace("difficulty changed to:" + diffList[diff]);
    }

    if (FlxG.keys.justPressed.DOWN)
    {
        diff++;
        FlxG.sound.play(Paths.sound("menu/scroll"), 0.7);

        if (diff >= 3) diff = 0;
        trace("difficulty changed to:" + diffList[diff]);
    }

    if (controls.ACCEPT)
    {
        if(diff == 2) PlayState.loadSong(songList[index], "easy", false, false);
        else if(diff == 1) PlayState.loadSong(songList[index], "hard", false, false);
        else if(diff == 0) PlayState.loadSong(songList[index], "normal", false, false);

        FlxG.switchState(new PlayState());
    }

    if(controls.BACK)
    {
        FlxG.sound.play(Paths.sound("menu/cancel"), 0.7);
        FlxG.switchState(new FreeplayState());
        trace("Opening Freeplay");
    }
}
