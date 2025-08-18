import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;

var menuBG:FlxSprite = null;
var menuOptions:Array<String> = ['menus/main/plays','menus/main/actors','menus/main/settings','menus/main/authors'];
var curIndex = 0;

function create()
{
   trace("This is the custom state.");

   menuBG = new FlxSprite(0,0);
   menuBG.loadGraphic(Paths.image(menuOptions[0]));
   add(menuBG);
}

function update(elapsed:Float)
{
    if(FlxG.keys.justPressed.ESCAPE)
    {
        FlxG.switchState(new TitleState());
    }

    if(FlxG.keys.justPressed.RIGHT)
    {
        curIndex++;

        FlxG.sound.play(Paths.sound('scrollMenu'));

        if(curIndex >= 3)
        {
            curIndex = 3;
        }

        trace(curIndex);
    }

    if(FlxG.keys.justPressed.LEFT)
    {
        curIndex--;

        FlxG.sound.play(Paths.sound('scrollMenu'));

        if(curIndex <= 0)
        {
            curIndex = 0;
        }

        trace(curIndex);
    }

    switch(curIndex)
    {
        case 0:
            menuBG.loadGraphic(Paths.image(menuOptions[0]));
        case 1:
            menuBG.loadGraphic(Paths.image(menuOptions[1]));
        case 2:
            menuBG.loadGraphic(Paths.image(menuOptions[2]));
        case 3:
            menuBG.loadGraphic(Paths.image(menuOptions[3]));
    }

    if(FlxG.keys.justPressed.ENTER)
    {
        FlxG.sound.play(Paths.sound('confirmMenu'));

        switchCrossState();
    }

    if(controls.SWITCHMOD)
    {
        persistentUpdate = !(persistentDraw = true);
		openSubState(new ModSwitchMenu());
    }

    if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = !(persistentDraw = true);
		openSubState(new EditorPicker());
	}
}

function switchCrossState()
{
    switch(curIndex)
    {
        case 0:
            FlxG.switchState(new ModState('cross/CrossFreeplay'));
        case 1:
            FlxG.switchState(new ModState('cross/CrossBios'));
        case 2:
            FlxG.switchState(new OptionsMenu());
        case 3:
            FlxG.switchState(new CreditsMain());
    }
}