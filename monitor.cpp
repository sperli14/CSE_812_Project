#include <iostream>
using namespace std;
#include <vector>

class Monitor {
    public:
        int id; //monitor id used for monitor-monitor communication
        string subformula; //piece of formula we will evaluate
        int num_monitors = 10; //number of monitors in system
        vector<bool> verdicts; //array of all the verdicts from every monitor, indices are monitor ids
        Monitor(int m_id, string m_subformula, int num_monitors) //constructor
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

};

int main() {

  Monitor m(0,"A and B", 3);
  m.verdicts[m.id] = true;

  Monitor n(1,"A and B", 3);
  cout << "before sharing:" << n.verdicts[0] << endl;
  m.ShareVerdict(&n);
  cout << "after sharing:" << n.verdicts[0] << endl;

  return 0;
}



