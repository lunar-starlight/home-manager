def preprocess(i): i | capture("^(?<type>.)(?<csv>.*)") | values;
def vol: .cmd.csv | capture("^(?<id>[^,]*),(?<vol>[^,]*),.*") as $cmd | {vols: {($cmd.id): $cmd.vol}};
def sink: {sink: .cmd.csv};
def ite(t): if t == "v" then vol elif t == "f" then sink else . end;
def tie(res): . // {} | . |= . * res | del(.cmd);
def postprocess: select(has("sink"));
#foreach inputs as $input ({}; values | .cmd = preprocess($input) | ite(.cmd.type); .)
foreach inputs as $input ({}; values | tie(.cmd = preprocess($input) | ite(.cmd.type)); .) | postprocess
