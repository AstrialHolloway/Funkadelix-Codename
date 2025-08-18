import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;

var menuBG:FlxSprite = null;

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


// -------------------------
// Credits (scrollable text)
// -------------------------
var creditsTexts:Array<FlxText> = [];
var scrollSpeed:Float = 40; // how fast text scrolls
var startingY:Float = 233; // first entry position
var baseY:Float; // store starting position of credits
var creditsGroup:FlxTypedGroup<FlxText>;
var baseY:Float = 233;
var creditsHeight:Float = 0; // 👈 now global so update() can see it

function addCreditText(x:Float, y:Float, width:Float, text:String, size:Int, font:String, center:Bool = true):FlxText
{
    var txt:FlxText = new FlxText(x, y, width, text);
    txt.size = size;
    txt.font = font;
    txt.alignment = center ? "center" : "left";
    add(txt);
    creditsTexts.push(txt);
    return txt;
}

{
    trace("Menu Loaded");

    creditsGroup = new FlxSpriteGroup();
    add(creditsGroup);
    baseY = creditsGroup.y; // save starting position

    // -------------------------
    // Paciofd
    // -------------------------
    var paciofdTitleDSText:FlxText = new FlxText(322, 235, 400, "Paciofd");
    paciofdTitleDSText.size = 50;
    paciofdTitleDSText.alignment = "center";
    paciofdTitleDSText.setFormat(FlxG.defaultFont, paciofdTitleDSText.size, FlxColor.BLACK, "left");
    paciofdTitleDSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(paciofdTitleDSText);

    var paciofdTitleText:FlxText = new FlxText(320, 233, 400, "Paciofd");
    paciofdTitleText.size = 50;
    paciofdTitleText.alignment = "center";
    paciofdTitleText.setFormat(FlxG.defaultFont, paciofdTitleText.size, FlxColor.WHITE, "left");
    paciofdTitleText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(paciofdTitleText);

    var paciofdL1DSText:FlxText = new FlxText(322, 295, 400, "- Artist\n- Composer\n- Lyricist\n- Charter");
    paciofdL1DSText.size = 25;
    paciofdL1DSText.alignment = "center";
    paciofdL1DSText.setFormat(FlxG.defaultFont, paciofdL1DSText.size, FlxColor.BLACK, "left");
    paciofdL1DSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(paciofdL1DSText);

    var paciofdL1Text:FlxText = new FlxText(320, 293, 400, "- Artist\n- Composer\n- Lyricist\n- Charter");
    paciofdL1Text.size = 25;
    paciofdL1Text.alignment = "center";
    paciofdL1Text.setFormat(FlxG.defaultFont, paciofdL1Text.size, FlxColor.WHITE, "left");
    paciofdL1Text.font = "assets/fonts/tommy.otf";
    creditsGroup.add(paciofdL1Text);

    // -------------------------
    // JamsDX
    // -------------------------
    var jamsdxTitleDSText:FlxText = new FlxText(768.5, 235, 400, "JamsDX");
    jamsdxTitleDSText.size = 50;
    jamsdxTitleDSText.alignment = "center";
    jamsdxTitleDSText.setFormat(FlxG.defaultFont, jamsdxTitleDSText.size, FlxColor.BLACK, "left");
    jamsdxTitleDSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(jamsdxTitleDSText);

    var jamsdxTitleText:FlxText = new FlxText(766.5, 233, 400, "JamsDX");
    jamsdxTitleText.size = 50;
    jamsdxTitleText.alignment = "center";
    jamsdxTitleText.setFormat(FlxG.defaultFont, jamsdxTitleText.size, FlxColor.WHITE, "left");
    jamsdxTitleText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(jamsdxTitleText);

    var jamsdxL1DSText:FlxText = new FlxText(768.5, 295, 400, "- Artist\n- Lyricist\n- Singer\n- Animator\n- Composer");
    jamsdxL1DSText.size = 25;
    jamsdxL1DSText.alignment = "center";
    jamsdxL1DSText.setFormat(FlxG.defaultFont, jamsdxL1DSText.size, FlxColor.BLACK, "left");
    jamsdxL1DSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(jamsdxL1DSText);

    var jamsdxL1Text:FlxText = new FlxText(766.5, 293, 400, "- Artist\n- Lyricist\n- Singer\n- Animator\n- Composer");
    jamsdxL1Text.size = 25;
    jamsdxL1Text.alignment = "center";
    jamsdxL1Text.setFormat(FlxG.defaultFont, jamsdxL1Text.size, FlxColor.WHITE, "left");
    jamsdxL1Text.font = "assets/fonts/tommy.otf";
    creditsGroup.add(jamsdxL1Text);

    // -------------------------
    // eggcat
    // -------------------------
    var eggcatTitleDSText:FlxText = new FlxText(322, 484, 400, "eggcat");
    eggcatTitleDSText.size = 50;
    eggcatTitleDSText.alignment = "center";
    eggcatTitleDSText.setFormat(FlxG.defaultFont, eggcatTitleDSText.size, FlxColor.BLACK, "left");
    eggcatTitleDSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(eggcatTitleDSText);

    var eggcatTitleText:FlxText = new FlxText(320, 482, 400, "eggcat");
    eggcatTitleText.size = 50;
    eggcatTitleText.alignment = "center";
    eggcatTitleText.setFormat(FlxG.defaultFont, eggcatTitleText.size, FlxColor.WHITE, "left");
    eggcatTitleText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(eggcatTitleText);

    var eggcatL1DSText:FlxText = new FlxText(322, 544, 400, "- UI Artist\n- Concept Artist");
    eggcatL1DSText.size = 25;
    eggcatL1DSText.alignment = "center";
    eggcatL1DSText.setFormat(FlxG.defaultFont, eggcatL1DSText.size, FlxColor.BLACK, "left");
    eggcatL1DSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(eggcatL1DSText);

    var eggcatL1Text:FlxText = new FlxText(320, 542, 400, "- UI Artist\n- Concept Artist");
    eggcatL1Text.size = 25;
    eggcatL1Text.alignment = "center";
    eggcatL1Text.setFormat(FlxG.defaultFont, eggcatL1Text.size, FlxColor.WHITE, "left");
    eggcatL1Text.font = "assets/fonts/tommy.otf";
    creditsGroup.add(eggcatL1Text);

    // -------------------------
    // isophoro
    // -------------------------
    var isophoroTitleDSText:FlxText = new FlxText(768.5, 484, 400, "isophoro");
    isophoroTitleDSText.size = 50;
    isophoroTitleDSText.alignment = "center";
    isophoroTitleDSText.setFormat(FlxG.defaultFont, isophoroTitleDSText.size, FlxColor.BLACK, "left");
    isophoroTitleDSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(isophoroTitleDSText);

    var isophoroTitleText:FlxText = new FlxText(766.5, 482, 400, "isophoro");
    isophoroTitleText.size = 50;
    isophoroTitleText.alignment = "center";
    isophoroTitleText.setFormat(FlxG.defaultFont, isophoroTitleText.size, FlxColor.WHITE, "left");
    isophoroTitleText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(isophoroTitleText);

    var isophoroL1DSText:FlxText = new FlxText(768.5, 544, 400, "- Programmer (Everything)\n- Charter");
    isophoroL1DSText.size = 25;
    isophoroL1DSText.alignment = "center";
    isophoroL1DSText.setFormat(FlxG.defaultFont, isophoroL1DSText.size, FlxColor.BLACK, "left");
    isophoroL1DSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(isophoroL1DSText);

    var isophoroL1Text:FlxText = new FlxText(766.5, 542, 400, "- Programmer (Everything)\n- Charter");
    isophoroL1Text.size = 25;
    isophoroL1Text.alignment = "center";
    isophoroL1Text.setFormat(FlxG.defaultFont, isophoroL1Text.size, FlxColor.WHITE, "left");
    isophoroL1Text.font = "assets/fonts/tommy.otf";
    creditsGroup.add(isophoroL1Text);

    // -------------------------
    // Kirzbiee (start off-screen so scrolling reveals it)
    // -------------------------
    var kirzbieeTitleDSText:FlxText = new FlxText(322, 752, 400, "Kirzbiee");
    kirzbieeTitleDSText.size = 50;
    kirzbieeTitleDSText.alignment = "center";
    kirzbieeTitleDSText.setFormat(FlxG.defaultFont, kirzbieeTitleDSText.size, FlxColor.BLACK, "left");
    kirzbieeTitleDSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(kirzbieeTitleDSText);

    var kirzbieeTitleText:FlxText = new FlxText(320, 750, 400, "Kirzbiee");
    kirzbieeTitleText.size = 50;
    kirzbieeTitleText.alignment = "center";
    kirzbieeTitleText.setFormat(FlxG.defaultFont, kirzbieeTitleText.size, FlxColor.WHITE, "left");
    kirzbieeTitleText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(kirzbieeTitleText);

    var kirzbieeL1DSText:FlxText = new FlxText(322, 812, 400, "- Lyricist\n- GF Singer");
    kirzbieeL1DSText.size = 25;
    kirzbieeL1DSText.alignment = "center";
    kirzbieeL1DSText.setFormat(FlxG.defaultFont, kirzbieeL1DSText.size, FlxColor.BLACK, "left");
    kirzbieeL1DSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(kirzbieeL1DSText);

    var kirzbieeL1Text:FlxText = new FlxText(320, 810, 400, "- Lyricist\n- GF Singer");
    kirzbieeL1Text.size = 25;
    kirzbieeL1Text.alignment = "center";
    kirzbieeL1Text.setFormat(FlxG.defaultFont, kirzbieeL1Text.size, FlxColor.WHITE, "left");
    kirzbieeL1Text.font = "assets/fonts/tommy.otf";
    creditsGroup.add(kirzbieeL1Text);

    // -------------------------
    // RecD (start off-screen so scrolling reveals it)
    // -------------------------
    var recdTitleDSText:FlxText = new FlxText(768.5, 752, 400, "RecD");
    recdTitleDSText.size = 50;
    recdTitleDSText.alignment = "center";
    recdTitleDSText.setFormat(FlxG.defaultFont, recdTitleDSText.size, FlxColor.BLACK, "left");
    recdTitleDSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(recdTitleDSText);

    var recdTitleText:FlxText = new FlxText(766.5, 750, 400, "RecD");
    recdTitleText.size = 50;
    recdTitleText.alignment = "center";
    recdTitleText.setFormat(FlxG.defaultFont, recdTitleText.size, FlxColor.WHITE, "left");
    recdTitleText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(recdTitleText);

    var recdL1DSText:FlxText = new FlxText(768.5, 812, 400, "- Spooky Kids Singer");
    recdL1DSText.size = 25;
    recdL1DSText.alignment = "center";
    recdL1DSText.setFormat(FlxG.defaultFont, recdL1DSText.size, FlxColor.BLACK, "left");
    recdL1DSText.font = "assets/fonts/tommy.otf";
    creditsGroup.add(recdL1DSText);

    var recdL1Text:FlxText = new FlxText(766.5, 810, 400, "- Spooky Kids Singer");
    recdL1Text.size = 25;
    recdL1Text.alignment = "center";
    recdL1Text.setFormat(FlxG.defaultFont, recdL1Text.size, FlxColor.WHITE, "left");
    recdL1Text.font = "assets/fonts/tommy.otf";

    creditsGroup.add(recdL1Text);
    var borderSprite:FunkinSprite = new FunkinSprite(-15,-5);
    borderSprite.loadGraphic(Paths.image("menus/credits/border"));
    add(borderSprite);

    var creditsSprite:FunkinSprite = new FunkinSprite(465.5,35.5);
    creditsSprite.loadGraphic(Paths.image("menus/credits/credits"));
    add(creditsSprite);

    var textColor2:String = "#148991"; 
    devText = new FlxText(327, 7, 600, "PRESS C TO OPEN CODENAME CREDITS", 10);
    devText.setFormat("fonts/freeplay.otf", 25,FlxColor.BLACK, "center");
    add(devText);


    devText = new FlxText(325, 5, 600, "PRESS C TO OPEN CODENAME CREDITS", 10);
    devText.setFormat("fonts/freeplay.otf", 25, Std.parseInt("0x" + textColor2.substr(1)), "center");
    add(devText);

    

    

    creditsHeight = 0;
    for (txt in creditsGroup.members)
    {
        if (Std.is(txt, FlxText))
            creditsHeight = Math.max(creditsHeight, txt.y + txt.height);
    }

}



// -------------------------
// Update loop
// -------------------------
function update(elapsed:Float)
{
    CoolUtil.playMenuSong();

    // -------------------------
    // Move tiles (background loop)
    // -------------------------
    for (tile in tileSprites)
    {
        tile.x -= tileMoveSpeedX * elapsed;
        tile.y += tileMoveSpeedY * elapsed;

        if(tile.x + tile.width < 0)
            tile.x += Math.ceil(screenWidth / tile.width + 1) * tile.width;

        if(tile.y > screenHeight)
            tile.y -= Math.ceil(screenHeight / tile.height + 1) * tile.height;
    }

    // scroll with mouse wheel
    if (FlxG.mouse.wheel != 0)
    {
        creditsGroup.y -= FlxG.mouse.wheel * scrollSpeed;

        // Clamp top
        if (creditsGroup.y > baseY)
            creditsGroup.y = baseY;

        // Clamp bottom
        var bottomY:Float = FlxG.height - creditsHeight;
        if (creditsGroup.y < bottomY)
            creditsGroup.y = bottomY;
    }
    

    if (FlxG.keys.justPressed.ESCAPE)
        FlxG.switchState(new MainMenuState());
    
    if (FlxG.keys.justPressed.C)
        FlxG.switchState(new CreditsMain());
}