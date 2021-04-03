// Project1.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <mysql.h>
#include <iostream>
#include <vector>
#include <string.h>
#include <fstream>
using namespace std;



int main()
{

	int result, i = 0, j = 0, pos;
	std::vector<string> table_names;
	std::vector<string> tables;
	string query;
	const char* q;

	MYSQL mysql;
	MYSQL_ROW row;
	MYSQL_RES* data;

	mysql_init(&mysql);

	if (mysql_real_connect(&mysql, "localhost", "root", "sai123", "openhab", 3306, NULL, 0)) {
		puts("Successful connection to database!");

		query = "show tables from openhab";
		q = query.c_str();
		result = mysql_query(&mysql, q);
		
		if (!result)
		{
			data = mysql_store_result(&mysql);
			while (row = mysql_fetch_row(data))
			{
				tables.push_back(string(row[0]));
			}
		}
		else
		{
			cout << "Query failed: " << mysql_error(&mysql) << endl;
		}

		query = "SELECT * FROM items";
		q = query.c_str();
		result = mysql_query(&mysql, q);

		if (!result)
		{
			data = mysql_store_result(&mysql);
			while (row = mysql_fetch_row(data))
			{
				table_names.push_back(string(row[0]));
				table_names.push_back(string(row[1]));
			}
		}
		else
		{
			cout << "Query failed: " << mysql_error(&mysql) << endl;
		}
		//for (string c : table_names) {
			//cout << c << "\n";
		//}

		
		int row_size = tables.size();
		std::vector<vector <string>> details(row_size);

		for (string table : tables) {
			std::vector<string> input;
			pos = table.find("m");
			string name = table.substr(pos + 1);
			ptrdiff_t index = find(table_names.begin(), table_names.end(), name) - table_names.begin();
			input.push_back(table_names[index + 1]);
			
			query = "SELECT * FROM " + string(table);
			q = query.c_str();
			result = mysql_query(&mysql, q);

			if (!result)
			{
				data = mysql_store_result(&mysql);
				
				while (row = mysql_fetch_row(data))
				{
					input.push_back(string(row[1]));
				}

				int col_size = input.size();
				
				details[i] = vector<string>(col_size);
				for (int j = 0; j < col_size; j++)
				{
					details[i][j] = input[j];
				}
				
			}
			else
			{
				cout << "Query failed: " << mysql_error(&mysql) << endl;
			}

			i++;
		}

		for (int i = 0; i < 50; i++) {
			for (int j = 0; j < details[i].size(); j++)
					cout << details[i][j] << " ";
					cout << endl;
				}

		fstream out("file.txt");
		for (i = 1; i < 50; i++)
		{
			for (j = 1; j < details[i].size(); j++)
				out << details[i][j];
			out << "\n";
		}
		out.close();
	}
	else {
		puts("Connection to database has failed!");
	}

	return 0;
}

