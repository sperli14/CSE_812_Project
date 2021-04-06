#include "z3++.h"
#include <string>
#include <math.h>
#include <fstream>
#include <iostream>
#include <filesystem>
#include <vector>
#include <time.h>
#include <omp.h>
#include <stdlib.h>

using namespace std;
using namespace z3;

class Monitor {
    public:
        int id; //monitor id used for monitor-monitor communication
        vector<string> subformula; //piece of formula we will evaluate - just the and, or operators
        //["and","or"]
        vector<bool> observations; //array of different boolean values from monitors
        //[true,false,false]
        //in this example, together this forms "true and false or false"
        int num_monitors = 10; //number of monitors in system
        vector<bool> verdicts; //array of all the verdicts from every monitor, indices are monitor ids
        vector<bool> verdicts_mod; //array that tells us which verdicts have been modified

        string traceFileName;

        //value and name and numEvents for segments of trace
        string EValue[10][100];
        string EName[10][100];
        int numProcess, numEvent[10];

        //value and numEvents for the entire trace file
        string EValueAll[10][100];
        int numEventAll[10];
        //happenBefore set
        int hbSet[50][2];
        int numHbSet;

        Monitor()
        {

        }

        Monitor(int m_id, vector<string> m_subformula, int m_num_monitors) //constructor
        {
            id = m_id;
            subformula = m_subformula;
            num_monitors = m_num_monitors;
            for(int c = 0; c < num_monitors; c++)
            {
                verdicts.push_back(false);
                verdicts_mod.push_back(false);
            }
            for(int i = 0; i < 10; i++)
            {
                for(int j = 0; j < 100; j++)
                {
                    EName[i][j] = "";
                    EValue[i][j] = "";

                    EValueAll[i][j] = "";
                }
                numEvent[i] = 0;
                numEventAll[i] = 0;
            }
            traceFileName = "details.txt";
            numProcess = 0;
            for(int i = 0; i < 50; i++)
            {
                hbSet[i][0] = 0;
                hbSet[i][1] = 0;
            }
            numHbSet = 0;
        }

        void setValues(int m_id, vector<string> m_subformula, int m_num_monitors, string traceFile)
        {
            traceFileName = traceFile;
            id = m_id;
            subformula = m_subformula;
            num_monitors = m_num_monitors;
            for(int c = 0; c < num_monitors; c++)
            {
                verdicts.push_back(false);
                verdicts_mod.push_back(false);
            }
            for(int i = 0; i < 10; i++)
            {
                for(int j = 0; j < 100; j++)
                {
                    EName[i][j] = "";
                    EValue[i][j] = "";

                    EValueAll[i][j] = "";
                }
                numEvent[i] = 0;
                numEventAll[i] = 0;
            }
            numProcess = 0;
            for(int i = 0; i < 50; i++)
            {
                hbSet[i][0] = 0;
                hbSet[i][1] = 0;
            }
            numHbSet = 0;
        }

        void GetVerdict(Monitor* m, unsigned position, bool verdict)//adopts verdict "verdict" from monitor m, stores it in index "position"
        {
            verdicts[position] = verdict;
            verdicts_mod[position] = true;

        }

        void ShareVerdict(Monitor* m)//shares own verdicts with monitor m
        {
            for(unsigned c=0;c<num_monitors;c++)
            {
                if(verdicts_mod[c])
                    m->GetVerdict(this, c, verdicts[c]);
            }
        }

        void readFile()
        {
            // cout << "In ReadFile" << endl;
            ifstream MyFile("details.txt");
            string line;
            int proc = 0, event = -1, num = 0;
            string word;
            numProcess = -1;

            while(getline(MyFile, line))
            {
                if(line.find("light") != -1 || line.find("switch") != -1)
                {
                    // cout << "1" << line << "\n";
                    numProcess++;
                }
                else
                {
                    EValueAll[numProcess][numEventAll[numProcess]++] = line;
                    // cout << EValueAll[numProcess][numEventAll[numProcess] - 1] << endl;
                }
            }
            MyFile.close();
        }

        void readSegTrace(int start, int end, int eps)
        {
            int i, j, num = 1;
            start = max(start - eps, 0);
            // cout << start << " : " << end << endl;
            for(i = 0; i < numProcess; i++)
            {
                numEvent[i] = 0;
                for(j = start; j < min(numEventAll[i], end); j++)
                {
                    EName[i][numEvent[i]] = to_string(num++);
                    EValue[i][numEvent[i]++] = EValueAll[i][j];
                }
                // cout << numEvent[i] << endl;
            }
            // cout << num << "\n";
            for(int i = 0; i < numProcess; i++)
            {
                for(int j = 0; j < numEvent[i]; j++)
                {
                    for(int k = 0; k < numProcess; k++)
                    {
                        for(int l = 0; l < numEvent[k]; l++)
                        {
                            if(abs(j - l) >= eps && i != k)
                            {
                                hbSet[numHbSet][0] = stoi(EName[i][j]);
                                hbSet[numHbSet++][1] = stoi(EName[k][l]);
                                // cout << "Happen Before: " << hbSet[numHbSet - 1][0] << " : " << hbSet[numHbSet - 1][1] << "\n";
                            }
                        }
                    }
                }
            }
        }

        bool solveSMT(int numFormula)
        {
            context c;

            solver s(c);

            expr_vector eventList(c);

            int totNumEvents = 0;
            for(int i = 0; i < numProcess; i++)
                totNumEvents += numEvent[i];
            // cout << totNumEvents << "\n";

            for(int i = 0; i < pow(totNumEvents, 2); i++)
            {
                std::string str = "eventList" + std::to_string(i);
                eventList.push_back(c.bv_const(str.c_str(), totNumEvents));
                s.add(eventList[i] == i);
            }

            func_decl f = z3::function("f", c.int_sort(), c.bv_sort(totNumEvents));

            s.add(f(0) == eventList[0]);

            for (int i = 0; i <= totNumEvents; i++)
            {
                expr_vector event_range(c);

                for (int j = 0; j < pow(totNumEvents, 2); j++)
                {
                    event_range.push_back(f(i) == eventList[j]);
                }

                s.add(mk_or(event_range));
            }

            for(int i = 0; i < totNumEvents; i++)
            {
                expr_vector event_order(c);

                for(int j = 1; j < pow(totNumEvents, 2); j = j * 2)
                    event_order.push_back(bv2int(f(i + 1), false) - bv2int(f(i), false) == j);

                // s.add(f(i + 1) > f(i));
                s.add(mk_or(event_order));
            }

            s.add(f(totNumEvents) == eventList[(int)pow(totNumEvents, 2) - 1]);

            expr x = c.int_const("x");
            s.add(0 <= x && x <= totNumEvents);

            expr_vector b1(c);
            expr_vector b2(c);

            for(int i = 0; i < numHbSet; i++)
            {
                std::string str = "b1" + std::to_string(i);
                b1.push_back(c.bv_const(str.c_str(), totNumEvents));
                str = "b2" + std::to_string(i);
                b2.push_back(c.bv_const(str.c_str(), totNumEvents));
                int p0 = (int)pow(2, hbSet[i][0] - 1);
                int p1 = (int)pow(2, hbSet[i][1] - 1);

                s.add(b1[i] == p1);
                s.add(b2[i] == p0);
                s.add(forall(x, implies(bv2int(f(x) & b1[i], false) != 0, bv2int(f(x) & b2[i], false) != 0)));
            }

            // func_decl_vector frontier(c);

            // for(int i = 0; i < numProcess; i++)
            // {
            //     std::string str = "frontier" + std::to_string(i);
            //     frontier.push_back(z3::function(str.c_str(), c.int_sort(), c.bv_sort(totNumEvents)));

            //     expr_vector frontier_order(c);

            //     for(int k = 0; k < totNumEvents; k++)
            //     {
            //         for(int j = 0; j < numEvent[i]; j++)
            //         {
            //             frontier_order.push_back(frontier[i](k) == EName[i][j]);
            //         }
            //         s.add(mk_or(frontier_order));
            //     }
            // }

            if(s.check() == sat)
            {
                // std::cout << "Sat" << std::endl;
                return true;

        //        model m = s.get_model();
        //        std::cout << m << std::endl;
            }
            else
            {
                // std::cout << "Unsat" << std::endl;
                return false;

            }
            s.reset();
        }

};

float average(float num[], int n)
{
    float sum = 0;
    for(int i = 0; i < n; i++)
        sum += num[i];
    return sum/n;
}

float standardDeviation(float num[], int n, float m)
{
    float sum = 0;
    for(int i = 0; i < n; i++)
    {
        sum += pow(num[i] - m, 2);
    }
    return sqrt(sum/n);
}

namespace fs = filesystem;

int main()
{
    clock_t startTime, endTime;
    float cenTime = 0.0, dCenTime = 0.0;
    string path = "bathroom", line;
    int numSwitch = 0, numLight = 0, numMonitor, mon = 0;
    Monitor monitorList[20];
    Monitor centMon;

    startTime = clock();
    for (const auto & entry : fs::directory_iterator("data"))
    {
        string fileName = entry.path();
        if(fileName.find(path + "switch") != -1)
            numSwitch++;
        else if(fileName.find(path + "light") != -1)
            numLight++;
    }

    numMonitor = numSwitch * numLight;
    ofstream outCFile;
    outCFile.open("detailsCen.txt");
    vector<string> formC;

    for(int plug = 1; plug <= numSwitch; plug++)
    {
        for(int light = 1; light <= numLight; light++)
        {
            // cout << plug << " : " << light << endl;

            ofstream outFile;
            outFile.open("detailsDist.txt");

            ifstream inFile;
            inFile.open("data/" + path + "switch_" + to_string(plug) + ".txt");
            while(getline(inFile, line))
            {
                outFile << line << endl;
                if(light == 1)
                    outCFile << line << endl;
            }
            inFile.close();

            inFile.open("data/" + path + "light_" + to_string(light) + ".txt");
            while(getline(inFile, line))
            {
                outFile << line << endl;
                outCFile << line << endl;
            }
            inFile.close();
            outFile.close();

            vector<string> form1;
            form1.push_back("data/" + path + "switch_" + to_string(plug));
            form1.push_back("data/" + path + "light_" + to_string(light));
            if(light == 1)
                formC.push_back("data/" + path + "switch_" + to_string(plug));
            formC.push_back("data/" + path + "light_" + to_string(light));

            monitorList[mon++].setValues(0, form1, numSwitch * numLight, "detailsDist.txt");
            // monitorList[mon++] = m;
            monitorList[mon - 1].readFile();
            // m.observations.push_back(true);
            // m.observations.push_back(true);

            // cout << "Before evaluation" << endl;
            // cout << m.verdicts[m.id] << endl;
            // m.Evaluate();
            // cout << "After evaluation" << endl;
            // cout << m.verdicts[m.id] << endl;
        }
    }
    outCFile.close();
    centMon.setValues(0, formC, 1, "detailsCen.txt");
    centMon.readFile();

    endTime = clock();
    cenTime += endTime - startTime;
    dCenTime += endTime - startTime;
    startTime = clock();

    int eps = 2, segLength = 4;
    int start = -segLength, end = 0;

    while(end <= centMon.numEventAll[0])
    {
        start = end;
        end += segLength;

        for(int i = 0; i < numMonitor; i++) {
            monitorList[i].readSegTrace(start, end, eps);

            for(int j = 0; j < monitorList[i].subformula.size(); j++)
                monitorList[i].verdicts_mod[j] = monitorList[i].solveSMT(j);

            endTime = clock();
            if(i == 1)
                dCenTime += endTime - startTime;
            startTime = clock();
        }

        startTime = clock();
        centMon.readSegTrace(start, end, eps);
        for(int j = 0; j < centMon.subformula.size(); j++)
                centMon.verdicts_mod[j] = centMon.solveSMT(j);
        endTime = clock();
        cenTime += endTime - startTime;

        startTime = clock();
        for(int i = 0; i < numMonitor; i++) {
            for(int j = 0; j < numMonitor; j++) {
                if(i != j)
                    monitorList[i].ShareVerdict(&monitorList[j]);
            }

            endTime = clock();
            if(i == 1)
                dCenTime += endTime - startTime;
            startTime = clock();
        }
    }

    cout << "Centralized Monitoring Time: " << cenTime / CLOCKS_PER_SEC;
    cout << " Decentralized Monitoring Time: " << dCenTime / CLOCKS_PER_SEC << endl;    

    return 0;
}