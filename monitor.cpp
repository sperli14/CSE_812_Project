#include <iostream>
using namespace std;
#include <vector>

class Monitor {
    public:
        int id; //monitor id used for monitor-monitor communication
        vector<string> subformula; //piece of formula we will evaluate - just the and, or operators
        //["and","or"]
        vector<bool> observations; //array of different boolean values from monitors
        //[true,false,false]

        int num_monitors = 10; //number of monitors in system
        vector<bool> verdicts; //array of all the verdicts from every monitor, indices are monitor ids

        Monitor(int m_id, vector<string> m_subformula, int num_monitors) //constructor
        {
            id = m_id;
            subformula = m_subformula;
            for(int c = 0; c < num_monitors; c++)
                verdicts.push_back(false);
        }
        void GetVerdict(Monitor* m, bool verdict)//adopts verdict "verdict" from monitor m, stores it in appropriate index of array
        {
            verdicts[m->id] = verdict;
        }
        void ShareVerdict(Monitor* m)//shares own verdict with monitor m
        {
            m->GetVerdict(this, true);
        }
        void Evaluate()
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
        }

};

int main() {
  vector<string> form;
  form.push_back("and");
  Monitor m(0,form, 3);
  m.observations.push_back(true);
  m.observations.push_back(false);
  cout << m.verdicts[m.id] << endl;
  //m.verdicts[m.id] = true;
  m.Evaluate();
  cout << m.verdicts[m.id] << endl;
  /*
  Monitor n(1,form, 3);
  cout << "before sharing:" << n.verdicts[0] << endl;
  m.ShareVerdict(&n);
  cout << "after sharing:" << n.verdicts[0] << endl;
*/
  return 0;
}



