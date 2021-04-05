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
        vector<Monitor*> network; //all other Monitors
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
        void AddNetwork(vector<Monitor*> m_network)
        {
            network = m_network;
        }
        void GetVerdict(Monitor* m, unsigned position, bool verdict)//adopts verdict "verdict" from monitor m, stores it in index "position"
        {
            verdicts[position] = verdict;
            verdicts_mod[position] = true;

        }
        void ShareVerdict()//shares own verdicts next monitor in stack
        {
            for(unsigned c=0;c<num_monitors;c++)
            {
                if(verdicts_mod[c])
                    network[(id+1)%num_monitors]->GetVerdict(this, c, verdicts[c]);
                    //m->GetVerdict(this, c, verdicts[c]);
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

int main() {


  vector<string> form1;
  form1.push_back("and");
  Monitor m1(0, form1, 3);
  m1.observations.push_back(true);
  m1.observations.push_back(true);
/*
  cout << "Before evaluation" << endl;
  cout << m1.verdicts[m1.id] << endl;
  m1.Evaluate();
  cout << "After evaluation" << endl;
  cout << m1.verdicts[m1.id] << endl;
*/
  //Adding some other value to show that multiple values get shared
  //m1.verdicts[8] = true;
  //m1.verdicts_mod[8] = true;

  //m.ShareVerdict(&m2);
  //for(unsigned c=0;c<3;c++)
    //cout << "After sharing:" << m2.verdicts[c] << endl;
  vector<string> form2;
  form2.push_back("or");
  Monitor m2(1, form2, 3);
  m2.observations.push_back(true);
  m2.observations.push_back(true);

  vector<string> form3;
  form3.push_back("or");
  Monitor m3(2, form3, 3);
  m3.observations.push_back(false);
  m3.observations.push_back(true);

  vector<Monitor*> monitors;
  monitors.push_back(&m1);
  monitors.push_back(&m2);
  monitors.push_back(&m3);
  m1.AddNetwork(monitors);
  m2.AddNetwork(monitors);
  m3.AddNetwork(monitors);

  m1.Evaluate();
  m2.Evaluate();
  m3.Evaluate();

  cout << "m1 before any sharing occurs" << endl;
  cout << m1.verdicts[0] << endl;
  cout << m1.verdicts[1] << endl;
  cout << m1.verdicts[2] << endl << endl;


  for(unsigned c = 0; c < 3; c++)
  {
      for(unsigned d = 0; d < 3; d++)
      {
          monitors[d]->ShareVerdict();
      }
  }

  cout << "m1 after all sharing ends" << endl;
  cout << m1.verdicts[0] << endl;
  cout << m1.verdicts[1] << endl;
  cout << m1.verdicts[2] << endl << endl;

  cout << "m1's final verdict:" << m1.Evaluate_All() << endl;

  return 0;
}



