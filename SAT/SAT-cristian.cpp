#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0


struct literal{
    int lit;                            //Indica el literal
    int pureCheck;                      //Utilitzat per comprobar si es u literal pur
    int apar;                           //Indica les apariciones d'aquest literal en les clausules
    vector<int> aparicionsTrue;         //Indica les clausules on apareix sense negar
    vector<int> aparicionsFalse;        //Indica les clausules on apareix negat
};
vector<literal> literals;


struct lits{
    uint lit;                           //Indica el literal
    uint index;                         //Indica la posicio d'aquest literal en el vector de literals
};
vector<lits> model;

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;
int maxAp, maxLit;                      //Enters utilitzats en la heuristica: s'encarreguen de trobar
                                        //un literal UNDEF en un conjunt de clausules que no es compleixen
                                        //i on apareix el literal 'lit'

void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit].lit = TRUE;
  else model[-lit].lit = FALSE;
}

bool comp(literal A, literal B){
    return A.apar > B.apar;
}

void checkPureLiteral(int lit){
    //Comprobacio de si un literal es pur: consisteix en sumar el valor que te aquest literal a les
    //clausules on apareix
    int index = abs(lit);
    literals[index].pureCheck += lit;
}

void eraseClauses(int index){
    //S'encarrega d'eliminar les clausules on apareix aquest literal. Aquest funcio nomes es utilitzada
    //per eliminar les clausules que tenen literals purs.
    int sizeT = literals[index].aparicionsTrue.size();
    int sizeF = literals[index].aparicionsFalse.size();
    for(int i=0; i<sizeT; ++i){
        clauses[literals[index].aparicionsTrue[i]].clear();
    }
    for(int i=0; i<sizeF; ++i){
        clauses[literals[index].aparicionsFalse[i]].clear();
    }
    literals[index].aparicionsTrue.clear();
    literals[index].aparicionsFalse.clear();
}

void checkPureClauses(){
    //Comproba si hi ha algun literal pur en el vector de literals. Per comprovar-ho, hem sumat totes les
    //aparicions d'aquest literal. Si 'n' es el nombre d'aparicions, sabrem que es pur si la suma
    //del valor que ha obtingut en les seves aparicions es igual a 'n' per ell mateix, en valors absoluts.
    int aparicions, sumaPureCheck;
    for(int i=0; i<literals.size(); ++i){
        aparicions = abs(literals[i].lit*literals[i].apar);
        sumaPureCheck = abs(literals[i].pureCheck);
        if(aparicions == sumaPureCheck)
            eraseClauses(i);
        setLiteralToTrue(literals[i].lit);
     }
}

void readClauses( ){
    // Skip comments
    char c = cin.get();
    while (c == 'c') {
        while (c != '\n') c = cin.get();
        c = cin.get();
    }
    // Read "cnf numVars numClauses"
    literal auxiliar;
    auxiliar.apar=0; auxiliar.lit=0; auxiliar.pureCheck=0;
    string aux;
    cin >> aux >> numVars >> numClauses;
    clauses.resize(numClauses);
    literals.resize(numVars+1, auxiliar);
    model.resize(numVars+1);
    // Read clauses
    int x;
    for (uint i = 0; i < numClauses; ++i) {
        int lit;
        while (cin >> lit and lit != 0) {
            checkPureLiteral(lit);
            x = abs(lit);
            literals[x].lit = lit;
            ++literals[x].apar;
            if(lit > 0) literals[x].aparicionsTrue.push_back(i); //el literal lit apareix a la clausula 'i'.
            else literals[x].aparicionsFalse.push_back(i);
            clauses[i].push_back(lit);
        }
    }

    sort(literals.begin(), literals.end(),comp);
    //Ordena el vector de literls en ordre decreixent segons el nombre d'aparicions.

    checkPureClauses();

    for(int i=0; i<literals.size(); ++i){
        x = abs(literals[i].lit);
        model[x].lit = UNDEF;
        model[x].index = i;
    }
}


int currentValueInModel(int lit){
    if (lit >= 0) return model[lit].lit;
    else {
        if (model[-lit].lit == UNDEF) return UNDEF;
        else return 1 - model[-lit].lit;
    }
}


bool propagateGivesConflict ( ) {

    int size, lit, index, lastLitUndef;
    vector<int> aparicions;
    while ( indexOfNextLitToPropagate < modelStack.size() ) {

        lit = abs(modelStack[indexOfNextLitToPropagate]);
        index = model[lit].index;
        if(model[lit].lit == TRUE){
            aparicions = literals[index].aparicionsFalse;
            size = literals[index].aparicionsFalse.size();
        }
        else{
            aparicions = literals[index].aparicionsTrue;
            size = literals[index].aparicionsTrue.size();
        }
        //En apareicions nom´es tenim les aparicion d'aquest literal on pugui influir

        ++indexOfNextLitToPropagate;
        for (int i = 0; i < size; ++i) {

            bool someLitTrue = false;
            uint numUndefs = 0;
            lastLitUndef = 0;
            int a = aparicions[i];
            int tam = clauses[a].size(); //nombre de literals a la clausula 'i'
            if(tam == 0) //si la clausula es buida, significa que l'hem eliminat per tenir un literal pur.
                someLitTrue = true;

            for (int k = 0; not someLitTrue and k < tam; ++k){
                int val = currentValueInModel(clauses[aparicions[i]][k]);
                if (val == TRUE) someLitTrue = true;
                else if (val == UNDEF){
                    ++numUndefs;
                    lastLitUndef = clauses[ aparicions[i] ][k];

                    if(maxAp < literals[model[abs(lastLitUndef)].index].apar){
                        //Agafa el literal UNDEF que mes aparicions tingui de tots el literals UNDEF que hem trobat
                        //al fer la propagacio.
                        maxAp = literals[model[abs(lastLitUndef)].index].apar;
                        maxLit = abs(lastLitUndef);
                    }
                }
            }
            if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
            else if (not someLitTrue and numUndefs == 1)            
                setLiteralToTrue(lastLitUndef);

        }
    }
    return false;
}



void backtrack(){
    uint i = modelStack.size() -1;
    int lit = 0;
    while (modelStack[i] != 0){ // 0 is the DL mark
        lit = modelStack[i];
        model[abs(lit)].lit = UNDEF;
        modelStack.pop_back();
        --i;
    }
    // at this point, lit is the last decision
    modelStack.pop_back(); // remove the DL mark
    --decisionLevel;
    indexOfNextLitToPropagate = modelStack.size();
    setLiteralToTrue(-lit);  // reverse last decision
}

// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
    if(maxLit != -1){
        //Si te algun literal UNDEF trobat en la propagacion es millor resoldre aquest literal, i aixi resoldre
        //clausules amb conflictes
        int lit = maxLit;
        maxLit = maxAp = -1;    //Reinicia els contadors
        return lit;
    }
    //Si no te cap literal, utilitza una heuristica estatica, on treu el UNDEF amb mes aparicions
    for (uint i = 0; i < numVars; ++i){ // stupid heuristic:
        if (model[abs(literals[i].lit)].lit == UNDEF)
            return abs(literals[i].lit);  // returns first UNDEF var, positively
    }
    return 0; // reurns 0 when all literals are defined
}

void checkmodel(){
    for (int i = 0; i < numClauses; ++i){
        bool someTrue = false;
        for (int j = 0; not someTrue and j < clauses[i].size(); ++j)
            someTrue = (currentValueInModel(clauses[i][j]) == TRUE);

        if(clauses[i].size() == 0)
        someTrue = true;
        if (not someTrue) {
            cout << "Error in model, clause is not satisfied:";
            for (int j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
            cout << endl;
            exit(1);
        }
    }
}

int main(){

    readClauses(); // reads numVars, numClauses and clauses

    indexOfNextLitToPropagate = 0;
    decisionLevel = 0;

    maxAp = maxLit = -1;

    // Take care of initial unit clauses, if any
    for (uint i = 0; i < numClauses; ++i)
        if (clauses[i].size() == 1) {
        int lit = clauses[i][0];
        int val = currentValueInModel(lit);
        if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
        else if (val == UNDEF) setLiteralToTrue(lit);
    }

    // DPLL algorithm
    int decisionLit;
    while (true) {
        while ( propagateGivesConflict() ) {
        if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
        backtrack();
    }
    decisionLit = getNextDecisionLiteral();

    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
    // start new decision level:

    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
    }
}
