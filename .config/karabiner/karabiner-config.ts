import {
    duoLayer,
    ifApp,
    layer,
    map,
    rule,
    ToEvent,
    toKey,
    toPointingButton,
    toSleepSystem,
    withMapper,
    withModifier,
    writeToProfile,
} from "karabiner.ts";

import {
    duoModifiers,
    historyNavi,
    switcher,
    tabNavi,
    tapModifiers,
    toClearNotifications,
} from "./utils";

writeToProfile(
    "Default profile",
    [
        sd_layer(),
        media_layer(),
        system_layer(),

        rule_duoModifiers(),
        general_map(),
        opt_window(),
        unix_mapping(),

        app_finder(),
        app_alfred(),
        app_kitty(),
        app_chromium(),
        app_orion(),
        app_arc(),
    ],
    {
        "basic.simultaneous_threshold_milliseconds": 40,
        "duo_layer.threshold_milliseconds": 40,
        "duo_layer.notification": false,
    }
);
function unix_mapping() {
    return rule("kitty", ifApp("^net.kovidgoyal.kitty").unless()).manipulators([
        map("u", "control").to("delete_or_backspace", "command"),
        map("w", "control").to("delete_or_backspace", "option")
    ]);
}

function general_map() {
    return rule("some general mappings").manipulators([
        map("left_command").to("left_command").toIfAlone("escape"),
        map("right_control").to("escape"),
    ]);
}

function opt_window() {
    return rule("option to window").manipulators([
        ...tapModifiers({
            '‹⌥': toKey('w', '⌥⇧'),
        }),
    ]);
}

function app_finder() {
    return rule("finder", ifApp("^com.apple.finder")).manipulators([
        map("q", "⌘").to("w", "⌘⌥"),
    ]);
}

function app_alfred() {
    return rule("alfred", ifApp("^com.runningwithcrayons.Alfred")).manipulators([
        map("j", "⌃").to("down_arrow"),
        map("k", "⌃").to("up_arrow"),
        map("c", "⌃").to("escape"),
    ]);
}

function app_kitty() {
    return rule("kitty", ifApp("^net.kovidgoyal.kitty")).manipulators([
        ...tabNavi(),
        ...historyNavi(),
        ...switcher(),
        ...tapModifiers({
            'l⇧': toKey('p', '⌃'),
            'r⇧': toKey('n', '⌃'),
        })
    ]);
}

function app_chromium() {
    return rule("brave", ifApp("^org.chromium.Chromium")).manipulators([
        ...tabNavi(),
        ...historyNavi(),
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('i', '⌘⌥'),
        }),
        //map('f', '⌃').to('t', '⌘')
    ]);
}
function app_orion() {
    return rule("orion", ifApp("^com.kagi.kagimacOS")).manipulators([
        ...tabNavi(),
        ...historyNavi(),
        ...switcher(),
    ]);
}
function app_arc() {
    return rule("arc", ifApp("^company.thebrowser.Browser")).manipulators([
        ...tabNavi(),
        ...historyNavi(),
        ...switcher(),
        ...tapModifiers({
            '›⌘': toKey('j', '⌘⌥'),
        })
    ]);
}
function media_layer() {
    let layer = duoLayer("f", "a");
    return layer.manipulators([
        withModifier("??")({
            spacebar: toKey('play_or_pause'),
            h: toKey("vk_consumer_previous"),
            j: toKey("volume_down"),
            k: toKey("volume_up"),
            l: toKey("vk_consumer_next"),
            o: toKey("display_brightness_increment"),
            i: toKey("display_brightness_decrement"),
        }),
    ]);
}
function sd_layer() {
    let layer = duoLayer("d", "s");
    //.toIfActivated(toPlaySound('Tink'))
    return layer.manipulators([
        withModifier("??")({
            h: toKey("←"),
            j: toKey("↓"),
            k: toKey("↑"),
            l: toKey("→"),

            c: toKey("‹⌥"),
            f: toKey("‹⌘"),
            spacebar: toKey("tab", "‹⌘"),

            y: toKey(4, "⇧"),
            u: toKey(5, "⇧"),
            i: toKey(6, "⇧"),
            o: toKey(7, "⇧"),
            p: toKey(8, "⇧"),

            b: toKey(1, "⇧"),
            n: toKey(2, "⇧"),
            m: toKey(3, "⇧"),

            "'": toKey("⌫"),
            "\\": toKey("⌦"),
        }),
    ]);
}

function symbol_layer() {
    let toSymbol = {
        "!": toKey(1, "⇧"),
        "@": toKey(2, "⇧"),
        "#": toKey(3, "⇧"),
        $: toKey(4, "⇧"),
        "%": toKey(5, "⇧"),
        "^": toKey(6, "⇧"),
        "&": toKey(7, "⇧"),
        "*": toKey(8, "⇧"),
        "(": toKey(9, "⇧"),
        ")": toKey(0, "⇧"),

        "[": toKey("["),
        "]": toKey("]"),
        "{": toKey("[", "⇧"),
        "}": toKey("]", "⇧"),

        "-": toKey("-"),
        "=": toKey("="),
        _: toKey("-", "⇧"),
        "+": toKey("=", "⇧"),

        ";": toKey(";"),
        "/": toKey("/"),
        ":": toKey(";", "⇧"),

        "<": toKey(",", "⇧"),
        ">": toKey(".", "⇧"),
    };

    let layer = duoLayer("s", "d");
    return layer.manipulators([
        withMapper({
            //h: '{',
            //l: '}',
            //g: '[',
            //';': ']',
            //j: '(',
            //k: ')',

            y: "$",
            u: "%",
            i: "^",
            o: "&",
            p: "*",

            b: "!",
            n: "@",
            m: "#",
        } as const)((k, v) => map(k).to(toSymbol[v])),

        { "'": toKey("⌫") },
    ]);
}

function rule_duoModifiers() {
    return rule("duo-modifiers").manipulators(
        duoModifiers({
            "⌃": ["fd", "jk"], // ⌃ second as Vim uses it
            "⌥": ["fs", "jl"], // ⌥ last as used the least
            //"⌘": ["fd", "jk"], // ⌘ first as used the most

            //'⇧': ['ds', 'kl'],

            "⌃⇧": ["gs", "hk"],
            "⌥⇧": ["gs", "hl"],
            //"⌘⇧": ["gd", "hk"],

            "⌘⌥": ["vc", "nm"],
            "⌘⌃": ["vx", "n,"],
            "⌥⌃": ["cx", "m,"],

            "⌘⌥⌃": ["vz", "n."],
        })
    );
}
function system_layer() {
    return layer('`', 'system').manipulators({
        //1: toMouseCursorPosition({ x: '25%', y: '50%', screen: 0 }),
        //2: toMouseCursorPosition({ x: '50%', y: '50%', screen: 0 }),
        //3: toMouseCursorPosition({ x: '75%', y: '50%', screen: 0 }),
        //4: toMouseCursorPosition({ x: '99%', y: 20, screen: 0 }),
        //5: toMouseCursorPosition({ x: '50%', y: '50%', screen: 1 }),
        1: toKey(1, 'left⌥'),
        2: toKey(2, 'left⌥'),
        3: toKey(3, 'left⌥'),
        4: toKey(4, 'left⌥'),
        5: toKey(5, 'left⌥'),

        '⏎': toPointingButton('button1'),

        n: toClearNotifications,

        '␣': toSleepSystem(),

        h: toKey('⇥', '⌘⇧'),
        l: toKey('⇥', '⌘'),
    })
}
function toIfActivated(arg0: ToEvent) {
    throw new Error("Function not implemented.");
}

