
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
	std::vector<string> sizes;
	std::vector<string> input1;
	string query;
	const char* q;

	MYSQL mysql;
	MYSQL_ROW row;
	MYSQL_RES* data;

	mysql_init(&mysql);

	if (mysql_real_connect(&mysql, "localhost", "root", "sai123", "light_switch", 3306, NULL, 0)) {
		puts("Connection Successful !");
		query = "show tables from light_switch";
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
			cout << "SQL Query failed: " << mysql_error(&mysql) << endl;
		}
		
		size_t row_size = tables.size();
		std::vector<vector <string>> details(row_size);

		for (string table : tables) {
			std::vector<string> input;
			
			input.push_back(table);
			table_names.push_back(table);
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

				size_t col_size = input.size();
				
				details[i] = vector<string>(col_size);
				for (int j = 0; j < col_size; j++)
				{
					details[i][j] = input[j];
				}
				
			}
			else
			{
				cout << "SQL Query failed: " << mysql_error(&mysql) << endl;
			}
			i++;
		}
		ofstream myfile;
		string filename;
		for (int i = 0; i < details.size(); i++) {
			filename = string(table_names[i]) + ".txt";
			myfile.open(filename);
			for (int j = 0; j < details[i].size(); j++) {
				myfile << details[i][j] ;
				myfile << "\n";
				cout << details[i][j] << "\n";
			}
			myfile.close();
			cout << endl;
		}
		
	}
	else {
		puts("Connection failed!");
	}

	return 0;
}

