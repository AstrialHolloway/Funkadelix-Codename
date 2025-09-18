static var redirectStates:Map<Dynamic, String> = [
    FreeplayState => "custom/freeplay",
    MainMenuState => "custom/main",
    StoryMenuState => "custom/story"
];

function preStateSwitch()
{   
    for(redirectState in redirectStates.keys())
    {
        if(Std.isOfType(FlxG.game._requestedState, redirectState))
        {
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
        }
    }
}