import {
    duoLayer,
    hyperLayer,
    ifApp,
    map,
    mapDoubleTap,
    rule,
    toHyper,
    toKey,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    historyNavi,
    switcher,
    tapModifiers,
    toClearNotifications,
    unix_mapping,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        easy_edit(),
        hyper(),
        system_layer(),

        general_map(),
        alfred_layer(),

        app_finder(),
        app_kitty(),
        app_browser(),
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
    }
);

function general_map() {
    return rule("some general mappings").manipulators([
        ...unix_mapping(),

        map("left_command").to("left_command").toIfAlone("escape"),
        map("'").to("left⌥").toIfAlone("'"),
        map("right_control").to("escape"),
        map("j", "option").to("tab", "command"),
        map("k", "option").to("tab", "⌘⇧"),
        map('h', '⌘').to('[', '⌘⇧'),
        map('l', '⌘').to(']', '⌘⇧'),

        mapDoubleTap('↑').to('↖︎'),
        mapDoubleTap('↓').to('end'),
    ]);
}

function app_finder() {
    return rule("finder", ifApp("^com.apple.finder")).manipulators([
        map("q", "⌘").to("w", "⌘⌥"),
    ]);
}

function app_kitty() {
    return rule("kitty", ifApp("^net.kovidgoyal.kitty")).manipulators([
        ...switcher(),
    ]);
}

function app_browser() {
    const browsers = [
        'Chromium',
        '^company.thebrowser.Browser',
        '^org.mozilla.com.zen.browser',
        'Orion',
        'Safari',
    ];
    return rule("Browser", ifApp(browsers)).manipulators([
        ...switcher(),
        ...historyNavi(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
        })
    ]);
}

function easy_edit() {
    let layer = duoLayer("f", "d").threshold(50)
    return layer.manipulators([
        withModifier("??")([
            map("h").to("←"),
            map("j").to("↓"),
            map("k").to("↑"),
            map("l").to("→"),

            map("s").to("‹⌘"),
            map("spacebar").to("‹⌥"),
            map("'").to("‹⇧"),

            map(",").to("delete_or_backspace"),
            map(".").to("⌦"),
            map("b").to("z", "<⌘"),
            map("n").to("x", "<⌘"),
            map("m").to("v", "<⌘"),
        ])
    ]);
}

function hyper() {
    //const aeros = '/opt/homebrew/bin/aerospace'
    //const ne = `${aeros} list-workspaces --monitor focused --empty no`
    return rule("quick").manipulators([
        map("'").to(toHyper()).toIfAlone("'"),

        withModifier("Hyper")([
            map('m').toApp('Activity Monitor'),
            //map('m').to$('. ~/.local/scripts/openBTOP.sh'),
            map('f').to$('open /System/Library/CoreServices/Finder.app'),
            map('a').toApp('ghostty'),
            map('s').to("2", "⌥"),
            map('d').toApp('ChatGPT'),
            map('g').toApp('obsidian'),
            map('4').to('4', '⌥'),
            map('5').to('5', '⌥'),

            //map('h').to$(`${ne} | ${aeros} workspace prev`),
            //map('l').to$(`${ne} | ${aeros} workspace next`),
            map('h').to("left_arrow"),
            map('l').to("right_arrow"),
            map('k').to("up_arrow"),
            map('j').to("down_arrow"),
        ]),

        withModifier("left⌥")([
            map('a').toApp('ghostty'),
            map('s').toApp('zen browser'),
            map('d').toApp('ChatGPT'),
            map('g').toApp('obsidian'),
        ])
    ])
}

function raycast() {
    return hyperLayer('r')
        .description('HyperLayer: r')
        .leaderMode({ escape: ['escape'] })
        .notification()
        .manipulators([
            map("o").to$("open -g raycast://extensions/EvanZhouDev/raycast-gemini/askAboutScreen?arguments=%7B%22query%22%3A%22%22%7D"),
            map("p").to$("open -g raycast://extensions/EvanZhouDev/raycast-gemini/askAI?arguments=%7B%22query%22%3A%22%22%7D"),
            map("a").to$("open -g raycast://extensions/joshmedeski/sesh/cmd-connect"),
            map("t").to$("open -g raycast://extensions/doist/todoist/search"),
            map("d").to$("open -g raycast://extensions/lardissone/raindrop-io/search"),
            map("q").to$("open -g raycast://extensions/rolandleth/kill-process/index"),
            map("j").to$("open -g raycast://extensions/thomas/downloads-manager/manage-downloads"),
            map("f").to$("open -g raycast://extensions/raycast/raycast-focus/toggle-focus-session"),
            map("c").to$("open -g raycast://extensions/raycast/clipboard-history/clipboard-history"),
        ])
}
function alfred_layer(){
    return hyperLayer("spacebar")
    .description('HyperSpace')
    .leaderMode({ escape: ['escape', 'spacebar'] })
    .notification()
    .manipulators([
        map("t").to("f1", "⌘⌥"),
        map("q").to("f2", "⌘⌥"),
        map("r").to("f3", "⌘⌥"),
        map("e").to("f4", "⌘⌥"),
        map("s").to("f12", "⌘⌥"),
    ])
}

function system_layer() {
    return duoLayer("z", "x").manipulators([
        withModifier("??")([
            map('return_or_enter').to('f', '⌥⇧'),
            map('\'').to('s', '⌥⇧'),
            map('l').to(']', '⌥'),
            map('h').to('[', '⌥'),
            map('j').to('tab', '⌘⇧'),
            map('k').to('tab', '⌘'),
            map('spacebar').to('left_shift'),

            map("delete_or_backspace").to(toClearNotifications),
            map("\\").toSleepSystem(),

            map("]").to("volume_up"),
            map("[").to("volume_down"),
            map("p").to("mute"),
            map("o").to("vk_consumer_next"),
            map("i").to('play_or_pause'),
            map("u").to("vk_consumer_previous"),
            map("=").to("display_brightness_increment"),
            map("-").to("display_brightness_decrement"),
        ]),
    ]);
}
function to(arg0: string, arg1: string): import("karabiner.ts").ToEvent | import("karabiner.ts").ToEvent[] | undefined {
    throw new Error("Function not implemented.");
}
