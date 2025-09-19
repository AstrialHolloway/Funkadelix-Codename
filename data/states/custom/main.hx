import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;

var lastIndex:Int = -1; // track previous selection

var shakeTimer:Float = 0;

var menuBG:FlxSprite = null;

var menuOptions:Array<String> = ['storymode','freeplay','gallery','options','credits'];

var gfOptions:Array<String> = ['menus/main/story mode_gf','menus/main/freeplay_gf','menus/main/gallery_gf','menus/main/options_gf','menus/main/gallery_gf'];

var curIndex = 0;

// -------------------------
// Background
// -------------------------
var backgroundSprite:FunkinSprite = new FunkinSprite(0, 0);
backgroundSprite.loadGraphic(Paths.image("menus/grad"));
add(backgroundSprite);

// -------------------------
// Moving Tiles (above background)
// -------------------------
var tileSprites:Array<FunkinSprite> = [];
var tileSize:Int = 114; // size of tile sprite
var screenWidth:Float = FlxG.width;
var screenHeight:Float = FlxG.height;
var tileMoveSpeedX:Float = 10; // pixels/sec left
var tileMoveSpeedY:Float = 10; // pixels/sec down

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
// Main Menu Sprites
// -------------------------
gf = new FlxSprite(25,58);
gf.loadGraphic(Paths.image(gfOptions[0]));
add(gf);

var coverSprite:FunkinSprite = new FunkinSprite(-90,-62);
coverSprite.frames = Paths.getSparrowAtlas("menus/main/mainmenu");
coverSprite.animation.addByPrefix("thing", "thing", 24, true);
coverSprite.animation.play("thing");
add(coverSprite);

var creditsSprite:FunkinSprite = new FunkinSprite(891,39.5);
creditsSprite.frames = Paths.getSparrowAtlas("menus/main/mainmenu");
creditsSprite.animation.addByPrefix("credits", "credits", 24, true);
creditsSprite.animation.play("credits");
add(creditsSprite);

var storymodeSprite:FunkinSprite = new FunkinSprite(540,99);
storymodeSprite.frames = Paths.getSparrowAtlas("menus/main/mainmenu");
storymodeSprite.animation.addByPrefix("storymode", "storymode", 24, true);
storymodeSprite.animation.play("storymode");
add(storymodeSprite);

var freeplaySprite:FunkinSprite = new FunkinSprite(641,247);
freeplaySprite.frames = Paths.getSparrowAtlas("menus/main/mainmenu");
freeplaySprite.animation.addByPrefix("freeplay", "freeplay", 24, true);
freeplaySprite.animation.play("freeplay");
add(freeplaySprite);

var gallerySprite:FunkinSprite = new FunkinSprite(705,374);
gallerySprite.frames = Paths.getSparrowAtlas("menus/main/mainmenu");
gallerySprite.animation.addByPrefix("gallery", "gallery", 24, true);
gallerySprite.animation.play("gallery");
add(gallerySprite);

var optionsSprite:FunkinSprite = new FunkinSprite(772,565);
optionsSprite.frames = Paths.getSparrowAtlas("menus/main/mainmenu");
optionsSprite.animation.addByPrefix("options", "options", 24, true);
optionsSprite.animation.play("options");
add(optionsSprite);

// Original sprite
var iconsSprite1:FunkinSprite = new FunkinSprite(1171, 0);
iconsSprite1.loadGraphic(Paths.image("menus/main/icons"));
add(iconsSprite1);

// Second sprite above the first
var iconsSprite2:FunkinSprite = new FunkinSprite(1171, -iconsSprite1.height);
iconsSprite2.loadGraphic(Paths.image("menus/main/icons"));
add(iconsSprite2);

// Third sprite above the second
var iconsSprite3:FunkinSprite = new FunkinSprite(1171, -iconsSprite1.height * 2);
iconsSprite3.loadGraphic(Paths.image("menus/main/icons"));
add(iconsSprite3);

var iconsSpeed:Float = 2; // pixels per frame


var iconsSpeed:Float = 0.3; // pixels per frame (adjust to your liking)

// -------------------------
// Create
// -------------------------


function create()
{
   trace("Main Menu Loaded");

   
}

// -------------------------
// Update
// -------------------------
function update(elapsed:Float)
{
    // Move all three sprites down
    iconsSprite1.y += iconsSpeed;
    iconsSprite2.y += iconsSpeed;
    iconsSprite3.y += iconsSpeed;

    // Loop sprites when they go off bottom
    if (iconsSprite1.y >= FlxG.height) iconsSprite1.y -= iconsSprite1.height * 3;
    if (iconsSprite2.y >= FlxG.height) iconsSprite2.y -= iconsSprite2.height * 3;
    if (iconsSprite3.y >= FlxG.height) iconsSprite3.y -= iconsSprite3.height * 3;

    
    CoolUtil.playMenuSong();

    // -------------------------
    // Move Tiles
    // -------------------------
    for (tile in tileSprites)
    {
        tile.x -= tileMoveSpeedX * elapsed;
        tile.y += tileMoveSpeedY * elapsed;

        // Wrap horizontally
        if(tile.x + tile.width < 0)
            tile.x += Math.ceil(screenWidth / tile.width + 1) * tile.width;

        // Wrap vertically
        if(tile.y > screenHeight)
            tile.y -= Math.ceil(screenHeight / tile.height + 1) * tile.height;
    }

    // -------------------------
    // Menu Controls
    // -------------------------
    handleInputs();

    // -------------------------
    // Scale Sprites Based on Selection
    // -------------------------
	handleSpriteShit();
}

function handleSpriteShit()
{
	if (curIndex != lastIndex)
    {
        lastIndex = curIndex;

        switch(curIndex)
        {
            case 0:
                creditsSprite.scale.set(1, 1);
                storymodeSprite.scale.set(1.1, 1.1);
                freeplaySprite.scale.set(1, 1);

                gf.loadGraphic(Paths.image(gfOptions[0]));
                gf.x = 25;
                gf.y = 30; // starting point

                // Tween to target y with bounce
                FlxTween.tween(gf, { y: 58 }, 0.4, { ease: FlxEase.backOut });
            case 1:
                storymodeSprite.scale.set(1, 1);
                freeplaySprite.scale.set(1.1, 1.1);
                gallerySprite.scale.set(1, 1);

                gf.loadGraphic(Paths.image(gfOptions[1]));
                gf.x = 25;
                gf.y = 30; // starting point

                // Tween to target y with bounce
                FlxTween.tween(gf, { y: 58 }, 0.4, { ease: FlxEase.backOut });
                
                
            case 2:
                freeplaySprite.scale.set(1, 1);
                gallerySprite.scale.set(1.1, 1.1);
                optionsSprite.scale.set(1, 1);

                gf.loadGraphic(Paths.image(gfOptions[2]));
                gf.x = 25;
                gf.y = 30; // starting point

                // Tween to target y with bounce
                FlxTween.tween(gf, { y: 58 }, 0.4, { ease: FlxEase.backOut });

            case 3:
                gallerySprite.scale.set(1, 1);
                optionsSprite.scale.set(1.1, 1.1);
                creditsSprite.scale.set(1, 1);

                gf.loadGraphic(Paths.image(gfOptions[3]));
                gf.x = 25;
                gf.y = 30; // starting point

                // Tween to target y with bounce
                FlxTween.tween(gf, { y: 58 }, 0.4, { ease: FlxEase.backOut });

            case 4:
                optionsSprite.scale.set(1, 1);
                creditsSprite.scale.set(1.1, 1.1);
                storymodeSprite.scale.set(1, 1);
                
                gf.loadGraphic(Paths.image(gfOptions[4]));
                gf.x = 25;
                gf.y = 30; // starting point

                // Tween to target y with bounce
                FlxTween.tween(gf, { y: 58 }, 0.4, { ease: FlxEase.backOut });
        }   
    }
}

function handleInputs()
{
	if(controls.BACK)
        FlxG.switchState(new TitleState());

    if(controls.DOWN_P)
    {
        curIndex++;
        FlxG.sound.play(Paths.sound('menu/scroll'));
        if(curIndex >= menuOptions.length) curIndex = 0;
        trace("Current Option:" + menuOptions[curIndex]);
    }

    if(controls.UP_P)
    {
        curIndex--;
        FlxG.sound.play(Paths.sound('menu/scroll'));
        if(curIndex < 0) curIndex = menuOptions.length - 1;
        trace("Current Option:" + menuOptions[curIndex]);
    }
	if(controls.ACCEPT)
    {
        switchCrossState();
    }

    if(controls.SWITCHMOD)
    {
        persistentUpdate = !(persistentDraw = true);
		openSubState(new ModSwitchMenu());
    }

    if (controls.DEV_ACCESS) {
		persistentUpdate = !(persistentDraw = true);
		openSubState(new EditorPicker());
	}
}

function switchCrossState()
{
    switch(curIndex)
    {
        case 0:
            FlxG.sound.play(Paths.sound('menu/confirm'));
            FlxG.switchState(new StoryMenuState());
            trace("Loading:" + menuOptions[curIndex]);
        case 1:
            FlxG.sound.play(Paths.sound('menu/confirm'));
            FlxG.switchState(new FreeplayState());
            trace("Loading:" + menuOptions[curIndex]);
        case 2:
            FlxG.sound.play(Paths.sound('CS_locked'));
            trace("Coming Soon");
            // FlxG.switchState(new ModState('custom/gallery'));
        case 3:
            FlxG.sound.play(Paths.sound('menu/confirm'));
            FlxG.switchState(new OptionsMenu());
            trace("Loading:" + menuOptions[curIndex]);
        case 4:
            FlxG.sound.play(Paths.sound('menu/confirm'));
            FlxG.switchState(new ModState('custom/credits'));
            trace("Loading:" + menuOptions[curIndex]);
    }
}
