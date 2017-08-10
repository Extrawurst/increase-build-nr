import std.regex;
import std.file;

int main(string[] args)
{
	import std.stdio : writefln, writeln;
	import std.conv : to;

	if (args.length < 3)
	{
		writeln("not enough arguments: expected 2");
		return -1;
	}

	immutable filename = args[1];

	immutable regularExpresssion = args[2];

	writefln("edit File: %s", filename);
	writefln("regex to match: %s", regularExpresssion);

	auto reg = regex(regularExpresssion);

	auto content = readText(filename);

	if (auto c = content.matchFirst(reg))
	{
		content = replaceFirst!(cap => to!string(to!int(cap.hit) + 1))(content, reg);

		write(filename, content);
	}
	else
	{
		writeln("version not found");
		return -1;
	}

	return 0;
}
