module main;

import pdb;

// Standard libs
import std.conv;
import std.stdio;
import std.getopt;
import std.parallelism;

void main(string[] args)
{
	string id;

	int cCPUS = 1;

	bool verbose = false;

	auto helpInformation = getopt(args,
		"id", "file id: id.pdb -> id.csv", &id,
		"cores", "number of cores", &cCPUS,
		"verbose", &verbose);

	if (helpInformation.helpWanted)
	{
		defaultGetoptPrinter("This program compute curvature and torsion for PDB files.",
			helpInformation.options);
	}

	int nCPUs = totalCPUs;
	if (cCPUS <= totalCPUs)
		nCPUs = cCPUS;

	if (verbose)
	{
		writeln();
		writeln("DiffGeo 0.1 [64 bits] - Copyright (c) 2022 Rinaldo Wander Montalvão");
		writeln();
		writefln("Threads : %d", nCPUs);
		writefln("PDB id  : %s", id);
	}

	try
	{
		auto pdb_file = new PDB(id, id ~ ".pdb", nCPUs, verbose);

		pdb_file.save_csv(id ~ ".csv");
	}
	catch (Exception e)
	{
		writeln();
		if (id.length == 0)
			writeln("Error: empty file id.");
		else
			writeln(e.msg);
	}
}
