import {
    duoLayer,
    hyperLayer,
    ifApp,
    layer,
    map,
    mapDoubleTap,
    rule,
    to$,
    toHyper,
    toKey,
    toSleepSystem,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    duoModifiers,
    switcher,
    tapModifiers,
    toClearNotifications,
    unix_mapping,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        //sd_layer(),
        //rule_duoModifiers(),
        hyper(),
        system_layer(),

        general_map(),
        raycast(),

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
    const browsers = ['Chromium', 'Arc', '^org.mozilla.com.zen.browser', 'Orion', 'Safari'];
    return rule("Browser", ifApp(browsers)).manipulators([
        map("spacebar", "⌃").to('tab', '⌃'),
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
        })
    ]);
}

function rule_duoModifiers() {
    return rule('duo-modifiers').manipulators(
        duoModifiers({
            'Meh': ['zx', ',.']
        }),
    )
}

function sd_layer() {
    let layer = duoLayer("d", "s").threshold(60)
    return layer.manipulators([
        withModifier("??")({
            h: toKey("←"),
            j: toKey("↓"),
            k: toKey("↑"),
            l: toKey("→"),

            spacebar: toKey("‹⌥"),
            f: toKey("‹⌘"),

            y: toKey(4, "⇧"),
            u: toKey(5, "⇧"),
            i: toKey(6, "⇧"),
            o: toKey(7, "⇧"),
            p: toKey(8, "⇧"),

            b: toKey(1, "⇧"),
            n: toKey(2, "⇧"),
            m: toKey(3, "⇧"),

            "'": toKey("⌫"),
            ";": toKey("⌦"),
            r: toKey("z", "<⌘"),
        }),
    ]);
}

function hyper() {
    const aeros = '/opt/homebrew/bin/aerospace'
    const ne = `${aeros} list-workspaces --monitor focused --empty no`
    return rule("quick").manipulators([
        map("'").to(toHyper()).toIfAlone("'"),

        withModifier("Hyper")([
            map('m').toApp('Activity Monitor'),
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
        .leaderMode()
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

function system_layer() {
    return duoLayer("z", "x").manipulators([
        withModifier("??")([
            map(';').to('f', '⌥⇧'),
            map('return_or_enter').to('s', '⌥⇧'),
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
