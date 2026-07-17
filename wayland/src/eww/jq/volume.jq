def preprocess(i): i | capture("^(?<type>.)(?<csv>.*)") | values;
def vol: .cmd.csv | capture("^(?<id>[^,]*),(?<vol>[^,]*),([^,]*),(?<mute>[^,]*)") as $cmd | {($cmd.id): {vol: $cmd.vol, mute: $cmd.mute}};
def dsink: {sink: .cmd.csv};
def nsink: .cmd.csv | capture("^(?<id>[^,]*),(?<name>[^,]*),(?<desc>[^,]*)") as $cmd | {($cmd.id): {name: $cmd.name, desc: $cmd.desc}};
def ite(t): if t == "v" then vol
            elif t == "f" then dsink
            elif t == "s" then nsink
            else . end;
def tie(res): . // {} | . |= . * res;
def postprocess: select(has("sink"));
foreach inputs as $input ({}; values | tie(.cmd = preprocess($input) | ite(.cmd.type)); .) | postprocess
