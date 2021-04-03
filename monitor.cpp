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



