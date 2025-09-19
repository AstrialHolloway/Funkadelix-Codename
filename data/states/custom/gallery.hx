import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;

var menuBG:FlxSprite = null;

var imageOptions:Array<String> = ['Monster Base Idle','Monster Base Left'];
var curImageIndex = 0;

// -------------------------
// Background
// -------------------------
var backgroundSprite:FunkinSprite = new FunkinSprite(0, 0);
backgroundSprite.loadGraphic(Paths.image("menus/grad"));
add(backgroundSprite);

// -------------------------
// Tiles (layered above background)
// -------------------------
var tileSprites:Array<FunkinSprite> = [];
var tileSize:Int = 114; // size of the tile sprite
var screenWidth:Float = FlxG.width;
var screenHeight:Float = FlxG.height;

// Movement speed
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
// Border
// -------------------------
var borderSprite:FunkinSprite = new FunkinSprite(-15,-5);
borderSprite.loadGraphic(Paths.image("menus/credits/border"));
add(borderSprite);

// -------------------------
// Current image
// -------------------------
var curImage:FlxSprite = null;

function create()
{
   trace("Gallery Loaded");

   curImage = new FlxSprite(0,0);
   curImage.loadGraphic(Paths.image("menus/gallery/"+imageOptions[curImageIndex]));
   add(curImage);
}

function switchCurGraphic(index:Int)
{
    if(index >= 0 && index < imageOptions.length)
        curImage.loadGraphic("menus/gallery/"+Paths.image(imageOptions[index]));
}

// -------------------------
// Update loop
// -------------------------
function update(elapsed:Float)
{
    CoolUtil.playMenuSong();

    // -------------------------
    // Move tiles
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
    // Controls
    // -------------------------
    
    handleInputs();
}

function handleInputs()
{
    if(controls.BACK)
        FlxG.switchState(new MainMenuState());

    if(controls.RIGHT_P)
    {
        curImageIndex++;
        FlxG.sound.play(Paths.sound('menu/scroll'));
        if(curImageIndex >= imageOptions.length) curImageIndex = 0;
        trace("Current Option:" + imageOptions[curImageIndex]);
        switchCurGraphic(curImageIndex);
    }

    if(controls.LEFT_P)
    {
        curImageIndex--;
        FlxG.sound.play(Paths.sound('menu/scroll'));
        if(curImageIndex < 0) curImageIndex = imageOptions.length - 1;
        trace("Current Option:" + imageOptions[curImageIndex]);
        switchCurGraphic(curImageIndex);
    }
}
