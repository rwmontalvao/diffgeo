// Copyright 2021 KU Leuven.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Author: Rinaldo Wander Montalvão, PhD
//
module main;

import pdb;

// Standard libs
import std.conv;
import std.stdio;
import std.getopt;
import std.parallelism;
import std.path : baseName, stripExtension; // Importing necessary functions from std.path
import std.stdio : writeln; // Importing writeln for output

string getSimpleName(string filePath) {
    // Extract the base filename using baseName
    string fileName = filePath.baseName;
    
    // Strip the extension using stripExtension
    fileName = fileName.stripExtension;

    return fileName;
}

void main(string[] args)
{
	string pdbPath;
	int cCPUS = 1;
	string outCsvPath;

	auto helpInformation = getopt(args,
		"pdbPath", "path of input PDB file", &pdbPath,
		"threads", "number of threads", &cCPUS,
		"outCsvPath", "path of output CSV file (default: ./filename.csv)", &outCsvPath);

	if (helpInformation.helpWanted)
	{
		defaultGetoptPrinter("This program compute curvature, torsion and writhing number for PDB files.",
			helpInformation.options);
	}

	else {
		// get simple name
		string filename = getSimpleName(pdbPath);

		// if output file path not provided, set simplename .csv as standard
		if (outCsvPath.length == 0)
				outCsvPath = "./" ~ filename ~ ".csv";
		
		int nCPUs = totalCPUs;
		if (cCPUS <= totalCPUs)
			nCPUs = cCPUS;

		writeln();
		writeln("DiffGeo Neural Network 0.1");
		writeln("Copyright (c) 2022 Rinaldo Wander Montalvão");
		writeln();
		writefln("Threads : %d", nCPUs);
		writefln("PDB id  : %s\n", filename);
		writefln("PDB path: %s\n", pdbPath);
		writefln("");
		try
		{
			auto pdb_file = new PDB(filename, pdbPath, nCPUs);

			string csv_path = outCsvPath;
			writefln("-> %s", csv_path);
			pdb_file.save_csv(csv_path);

		}
		catch (Exception e)
		{
			writeln();
			if (pdbPath.length == 0)
				writeln("Error: empty file path.");
			else
				writeln(e.msg);
		}
	}
}
