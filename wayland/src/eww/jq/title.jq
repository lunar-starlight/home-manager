def preprocess(i): i | values | .data.events;
def title: .cmd;
def output: .cmd;
def ite(t): if t == "SeatFocusedView" then title
            elif t == "SeatFocusedOutput" then output
            else . end;
def tie(res): . // {} | . |= . * res | del(.cmd) | select(.name != null) | . |= . * {out: {(.name): .title}};
def postprocess: select(.__typename == "SeatFocusedView") | .out;
foreach inputs as $input ({}; values | tie(.cmd = preprocess($input) | ite(.cmd.__typename)); .) | postprocess
