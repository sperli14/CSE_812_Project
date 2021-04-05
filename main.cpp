#include "z3++.h"
#include <string>
#include <math.h>
#include <fstream>
#include <iostream>
#include <vector>
#include <time.h>
#include <omp.h>
#include <stdlib.h>

class createSMT
{
private:
    string traceFileName;
    string EValue[10][100];
    string EName[10][100];
    int numProcess, numEvent[10];

    string EValueAll[10][100];
    int numEventAll[10];
    int hbSet[50][2];
    int numHbSet;

    void readFile();
    void readSegTrace(int, int, int);

public:
    createSMT();
    createSMT(string);
    void makeSMTProg(int, int, int, string, int);
    bool solveSMTProg(string[10], int, int, int, int, int);
};

createSMT::createSMT()
{
    traceFileName = "toilet_details.txt";
    int i, j;
    for(i = 0; i < 10; i++)
    {
        for(j = 0; j < 100; j++)
        {
            EName[i][j] = "";
            EValue[i][j] = "";

            EValueAll[i][j] = "";
        }
        numEvent[i] = 0;
        numEventAll[i] = 0;
    }
    numProcess = 0;
    for(i = 0; i < 50; i++)
    {
        hbSet[i][0] = 0;
        hbSet[i][1] = 0;
    }
    numHbSet = 0;
}

createSMT::createSMT(string one)
{
    traceFileName = one;
    int i, j;
    for(i = 0; i < 10; i++)
    {
        for(j = 0; j < 100; j++)
        {
            EName[i][j] = "";
            EValue[i][j] = "";

            EValueAll[i][j] = "";
        }
        numEvent[i] = 0;
        numEventAll[i] = 0;
    }
    numProcess = 0;
    for(i = 0; i < 50; i++)
    {
        hbSet[i][0] = 0;
        hbSet[i][1] = 0;
    }
    numHbSet = 0;
}

void createSMT::readFile()
{
    ifstream MyFile(traceFileName);
    string line;
    int proc = 0, event = -1, num = 0;
    string word;
    numProcess = -1;

    while(getline(MyFile, line))
    {
        if(line.find("light") != -1 || line.find("switch"))
        {
            // cout << "1" << line << "\n";
            numProcess++;
        }
        else
        {
            EValueAll[numProcess][numEventAll[numProcess]++] = stoi(line);
            cout << EValueAll[numProcess][numEventAll[numProcess] - 1] << endl;
        }
    }
    MyFile.close();
}

void createSMT::readSegTrace(int start, int end, int eps)
{
    int i, j, num = 1;
    start = max(start - eps, 0);
    // cout << start << " : " << end << endl;
    for(i = 0; i < numProcess; i++)
    {
        numEvent[i] = 0;
        for(j = start; j < min(numEventAll[i], end); j++)
        {
            numEvent[i]++;
            EName[i][j] = to_string(num++);
            EValue[i][j] = EValueAll[i][j];
        }
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
                    if(abs(numEvent[i] - EName[i][j] - EName[k][l] + numEvent[k]) >= eps && i != k)
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

void createSMT::makeSMTProg(int eps, int segLength, int maxTime, string phi, int numThreads)
{
    readFile();

    string formulaList[10];
    int numFormula = 2;
    string currentFormula[10];

    int start, end;
    start = -segLength;
    end = 0;

    int resultMat[50][10];
    for(int  i = 0; i < int (maxTime/ segLength) + 1; i++)
    {
        for(int j = 0; j < 2 * numFormula; j++)
        {
                resultMat[i][j] = 0;
        }
    }

    int numSegment = -1;
    int segmentL = maxTime/numThreads;
    #pragma omp parallel num_threads(numThreads)
    {
        for(int seg = 0; seg < maxTime; seg = seg + segmentL)
        {
            numSegment++;
            start = seg;
            end = seg + segmentL;
            // cout << start << " : " << end << endl;
            solveSMTProg(formulaList, numFormula, start, end, segLength, eps);

            // readSegTrace(start, end, eps);
            // numFormula = 4;
            // for (int i = 0; i < 2 * numFormula; i++) {
            //     // cout << statesList[i] << " : " << statesList[j] << "\n";
            //     resultMat[numSegment][i] = solveSMTProg(formulaList[i / 2], i % 2);
            // }
        }
    }

    // for(int i = 0; i < numSegment; i++) {
    //     string newCurrentFormula[10];
    //     int numNewCurrentFormula = 0;
    //     for(int j = 0; j < numCurrentFormula; j++) {
    //         for(int k = 0; k < numFormula; k++) {
    //             if(formulaList[k] == currentFormula[j]) {
    //                 for(int l = 0; l < numFormula; l++) {
    //                     if(resultMat[i][k][l] == 1)
    //                         newCurrentFormula[numNewCurrentFormula ++] = formulaList[l];
    //                 }
    //             }
    //         }
    //     }
    //     numCurrentFormula = 0;
    //     for(int j = 0; j < numNewCurrentFormula; j++) {
    //         currentFormula[numCurrentFormula++] = newCurrentFormula[j];
    //     }
    // }
}

bool createSMT::solveSMTProg(string formulaList[10], int numFormula, int segStart, int segEnd, int segLength, int eps)
{
    context c;

    solver s(c);

    int start = segStart - segLength, end = segStart;
    int result = 0;
    while(end <= segEnd)
    {
        start += segLength;
        end += segLength;

        readSegTrace(start, end, eps);

        for(int n = 0; n < 2 * numFormula; n++)
        {
            // cout << start << " : " << end << endl;
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
                result = 1;
                cout << s.get_model() << endl;
            }
            else
            {
                result = 0;
            }

            s.reset();
        }
    }

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
}

class mainProg
{
private:
    int numCores;
    float average(float*, int);
    float standardDeviation(float*, int, float);

public:
    mainProg();
    mainProg(int);
    void execute();
};

mainProg::mainProg()
{
    numCores = 1;
}

mainProg::mainProg(int num)
{
    numCores = num;
}

float mainProg::average(float num[], int n)
{
    float sum = 0;
    for(int i = 0; i < n; i++)
        sum += num[i];
    return sum/n;
}

float mainProg::standardDeviation(float num[], int n, float m)
{
    float sum = 0;
    for(int i = 0; i < n; i++)
    {
        sum += pow(num[i] - m, 2);
    }
    return sqrt(sum/n);
}

void mainProg::execute()
{
    // cout << "hi";
//    SynthExp synthExp("trace2_20.txt", "pq", 2, 20);
//    synthExp.genTrace();
    int numIter = 10;
    float result[10];
    float meanTime, sdTime;
    clock_t runTime;

    // ofstream outFile;
    // outFile.open("report.csv");
    // outFile << "numProcess, segLength, compLength, eps, eventRate, cenTime, cenTime-SD, distTime, distTime-SD" << endl;

    int compLength = 200;
    int eps = 25;
    // int numProcess = 2;
    // int segLength = 16;
    int eventRate = 10;

    // string traceFile = "trace" + to_string(numProcess) + "_" + to_string(int(compLength / 10));
    // string command = "python synth-system.py " + to_string(numProcess) + " " + to_string(compLength) + " " + traceFile + " " + to_string(eventRate);
    // system(command.c_str());

    // cout << "numProcess: " << numProcess << " compLength: " << compLength << " segLength: " << segLength << " eps: " << eps << "\n";
    // outFile << numProcess << ", " << segLength << ", " << compLength << ", " << eps << ", " << eventRate << ", ";

    for(int i = 0; i < numIter; i++)
    {
        runTime = clock();
        createSMT smtCen(traceFile);
        smtCen.readFile();
        smtMon.makeSMTMon(eps, segLength, compLength, numCores);
        runTime = clock() - runTime;
        result[i] = (float) runTime / CLOCKS_PER_SEC;
        // cout << result[i] << endl;
    }

    meanTime = average(result, numIter);
    sdTime = standardDeviation(result, numIter, meanTime);
    cout << "CentralizedTime: " << meanTime << ", SD: " << sdTime << endl;
    outFile << meanTime << ", " << sdTime << ", ";

    for(int i = 0; i < numIter; i++)
    {
        runTime = clock();
        createSMTProg smtProg(traceFile);
        smtProg.makeSMTProg(eps, segLength, compLength, "<> r -> ( ! p U r)", numCores);
        runTime = clock() - runTime;
        result[i] = (float) runTime / CLOCKS_PER_SEC;
        // cout << result[i] << endl;
    }

    meanTime = average(result, numIter);
    sdTime = standardDeviation(result, numIter, meanTime);
    cout << "DecentralizedTime: " << meanTime << ", SD: " << sdTime << endl;
    outFile << meanTime << ", " << sdTime << endl;

    outFile.close();
}

#include <iostream>
#include <vector>
#include <stdio.h>
using namespace std;

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
        void Evaluate()//evaluates own subformula
        {
            vector<bool> sub_verdict;
            for(unsigned c=1;c<observations.size(); c++)
            {
                if(c==1)
                {
                    bool verd;
                    if(subformula[c-1]=="and")
                        verd = observations[c] && observations[c-1];
                    else
                        verd = observations[c] || observations[c-1];
                    sub_verdict.push_back(verd);
                }
                if(c>1)
                {
                    bool verd;
                    if(subformula[c-1]=="and")
                        verd = observations[c] && sub_verdict[c-2];
                    else
                        verd = observations[c] || sub_verdict[c-2];
                    sub_verdict.push_back(verd);
                }
            }
            verdicts[id] = sub_verdict.back();
            verdicts_mod[id] = true;
        }
        bool Evaluate_All()//evaluates all subformulas into one formula
        {
            //formula is in form S1 and S2 and S3... such that Sk is the kth subformula
            //if any of these sub-verdicts are false, our verdict is false
            for(unsigned c=0;c<num_monitors;c++)
            {
                if(verdicts[c] == false)
                    return false;
            }
            return true;
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

int main() {
  vector<string> form1;
  form1.push_back("and");
  vector<string> form2;
  form2.push_back("and");

  Monitor m(0,form1, 10);
  m.observations.push_back(true);
  m.observations.push_back(true);

  cout << "Before evaluation" << endl;
  cout << m.verdicts[m.id] << endl;
  m.Evaluate();
  cout << "After evaluation" << endl;
  cout << m.verdicts[m.id] << endl;

  //Adding some other value to show that multiple values get shared
  m.verdicts[8] = true;
  m.verdicts_mod[8] = true;


  Monitor n(1,form2, 10);
  for(unsigned c=0;c<10;c++)
    cout << "Before sharing:" << n.verdicts[c] << endl;
  cout << endl << "Sharing..." << endl << endl;
  m.ShareVerdict(&n);
  for(unsigned c=0;c<10;c++)
    cout << "After sharing:" << n.verdicts[c] << endl;

  return 0;
}