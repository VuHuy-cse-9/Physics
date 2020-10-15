#include<iostream>
#include<fstream>
#include<string.h>
#include<vector>

//TODO: Extract yTokens.

using namespace std;

template<typename T>
double addition(char, T, double);
double multiply(char, char, double);
double findOperand(char op, double h);
void extractTokens(const vector<char>* , const vector<char>*,
                  vector<string>*, vector<string>*,
                  int);
void transform(double***, const vector<string>*, 
            int, double, int);
void format(const vector<string>&, vector<char>*, vector<char>*);

int main() {
      ifstream input("coordinate_H.txt", std::ios::binary | std::ios::in);
      ofstream output("input.csv", std::ios::binary | std::ios::out);
      ofstream filename("name.csv", std::ios::binary | std::ios::out);
      if (input.eof() /*|| output.eof()*/) {
            cout << "Don't have file" << endl;
            return -1;
      }
      
      double h;
      input.ignore(1024, '=');
      input >> h;
      input.ignore(1024, '\n'); 

      char c;
      string str;
      vector<string> caseId, coordinate;
      vector<char>* xCoordinate, *yCoordinate;
      vector<string>* xTokens, *yTokens;
      double*** dCoordinate;
      while(input.good()) {
            //caseId:
            getline(input, str, '=');
            caseId.push_back(str);
            //Coordinate:
            input.ignore(1024, '[');
            getline(input,str,']');
            coordinate.push_back(str);
            input.ignore(1024, '\n');
      }
      xCoordinate = new vector<char>[coordinate.size()];
      yCoordinate = new vector<char>[coordinate.size()];
      xTokens     = new vector<string>[coordinate.size()];
      yTokens     = new vector<string>[coordinate.size()];
      dCoordinate = new double**[coordinate.size()];
      
      //Format input file to 1 axis equal space string. e.g: k k k+1 k+2 
      format(coordinate, xCoordinate, yCoordinate);

      //Extract from all 1 axis Coodinate in string to pair of string coodinate. 
      extractTokens(xCoordinate, yCoordinate, xTokens, yTokens, coordinate.size());

      //Creat dCoordinate:
      for (int i = 0; i < coordinate.size(); ++i) {
            dCoordinate[i] = new double*[xTokens[i].size()];
            for (int j = 0; j < xTokens[i].size(); ++j) {
                  dCoordinate[i][j] = new double[2];
            }
      }
      //Transform from string pair coordinate to double coordinate.
      transform(dCoordinate, xTokens, coordinate.size(), h, 0);
      transform(dCoordinate, yTokens, coordinate.size(), h, 1);

      //Print for test.
      // for (int i = 0; i < coordinate.size(); ++i) {
      //       for (int j = 0; j < xTokens[i].size(); ++j) {
      //             cout << dCoordinate[i][j][0] << " " << dCoordinate[i][j][1] << '\n';
      //       }
      // }

      //export input.csv
      for (int i = 0; i < coordinate.size(); ++i) {
            for (int j = 0; j < xTokens[i].size(); ++j) {
                  output << dCoordinate[i][j][0];
                  if ((j + 1) != xTokens[i].size()) 
                        output << ',';
                  else
                        output << '\n';
            }
            for (int j = 0; j < yTokens[i].size(); ++j) {
                  output << dCoordinate[i][j][1];
                  if ((j + 1) != yTokens[i].size()) 
                        output << ',';
                  else
                        output << '\n';
            }
      }

      //Export name to name.txt
      for (int i = 0; i < caseId.size(); ++i) {
            filename << caseId.at(i) << '\n';
      }


      delete[] xCoordinate;
      delete[] yCoordinate;
      for (int i = 0; i < coordinate.size(); ++i) {
            for (int j = 0; j < xTokens[i].size(); ++j) {
                  delete[] dCoordinate[i][j];
            } 
            delete[] dCoordinate[i];
      }
      delete[] dCoordinate;
      input.close();
      output.close();
      return 0;
}

void extractTokens(const vector<char>* xCoordinate, const vector<char>* yCoordinate,
                  vector<string>* xTokens, vector<string>* yTokens,
                  int size) {
      int indexTokens = 0;
      string tokens;
      char c;
      for (int i = 0; i < size; ++i) {
            for (int j = 0; j < xCoordinate[i].size(); ++j) {
                  if (xCoordinate[i].at(j) != ' ') {
                        c = xCoordinate[i].at(j);
                        tokens.push_back(c);
                  }
                  if (xCoordinate[i].at(j) == ' ' || j + 1 == xCoordinate[i].size()) {
                        ++indexTokens;
                        xTokens[i].push_back(tokens);
                        tokens.clear();
                  }             
            }
            if (!tokens.empty()) tokens.clear();
            indexTokens = 0;

            for (int j = 0; j < yCoordinate[i].size(); ++j) {
                  if (yCoordinate[i].at(j) != ' ') {
                        c = yCoordinate[i].at(j);
                        tokens.push_back(c);
                  }
                  if (yCoordinate[i].at(j) == ' ' || j + 1 == yCoordinate[i].size()) {
                        ++indexTokens;
                        yTokens[i].push_back(tokens);
                        tokens.clear();
                  }             
            }
      }
      
}

double findOperand(char op, double h) {
      if (47 < op && op < 58) {
            return op - 48;
      }
      else if (op == 'h') {
            return h;
      }
      else if (op == 'k') {
            return h/2;
      } 
      else {
            cout << "Don't math and variable" << '\n';
            return -1;
      }
}

template<typename T>
double addition(char op1, T op2, double h) {
      double o1, o2;
      if (typeid(T) == typeid(double)) o2 = op2;
      else if(typeid(T) == typeid(char)) {
            o2 = findOperand(op2, h);
      }
      else {
            cout << "No match type" << '\n';
            return -2;
      }
      o1 = findOperand(op1, h); 
      return o1 + o2;
}


double multiply(char op1, char op2, double h) {
      double o1 = findOperand(op1, h);
      double o2 = findOperand(op2, h);
      return o1*o2;
}

void transform(double*** dCoordinate, const vector<string>* tokens,
            int size, double h, int label) {
      //TODO: Transsform + Sign to coordinate.
      int k = h / 2;
      int x = 0;
      double op2(0), op1(0);
      for (int i = 0; i < size; ++i) {
            for (int j = 0; j < tokens[i].size(); ++j) {
                  op2 = 0; op1 = 0; 
                  //Find *:
                  x = 0;
                  while(x < tokens[i].at(j).size()) {
                        if (tokens[i].at(j).at(x) == '*') {
                              if (x + 1 == tokens[i].at(j).size()) {
                                    cout << "Out of range" << '\n';
                                    break;
                              }
                              op2 = multiply(tokens[i].at(j).at(x-1), tokens[i].at(j).at(x+1), h);
                        }
                        ++x;
                  }
                  //Find +:
                  x = 0;
                  while (x < tokens[i].at(j).size()) {
                        if (tokens[i].at(j).at(x) == '+') {
                              if (x + 1 == tokens[i].at(j).size()) {
                                    cout << "Out of range" << '\n';
                                    break;
                              }
                              if (op2 != 0) op1 = addition(tokens[i].at(j).at(x-1), op2, h);
                              else  op1 = addition(tokens[i].at(j).at(x-1), 
                                          tokens[i].at(j).at(x+1), h);
                        }
                        ++x;
                  }
                  if (op1 == 0) dCoordinate[i][j][label] = findOperand(tokens[i].at(j).at(0), h);
                  else dCoordinate[i][j][label] = op1;
            }
      }
      
};

void format(const vector<string>& coordinate, vector<char>* xCoordinate, vector<char>* yCoordinate) {
      int j = 0;
      bool max = false;
      char c;
      int i = 0;

      for (int i = 0; i < coordinate.size(); ++i) {
            j = 0;
            max = false;
            while (j < coordinate.at(i).size()) {
                  while(coordinate.at(i).at(j) != ' ') {
                        c = coordinate.at(i).at(j);
                        xCoordinate[i].push_back(c);
                        if ((j + 1) == coordinate.at(i).size()) {
                              max = true;
                              break;
                        }
                        ++j;
                  }

                  if (max) break;
                  while(coordinate.at(i).at(j) == ' ' &&
                  j < coordinate.at(i).size()) {
                        if ((j + 1) == coordinate.at(i).size()) {
                              max = true;
                              break;
                        }
                        ++j;
                  }

                  if (max) break;                  
                  while(coordinate.at(i).at(j) != ';' && 
                  j < coordinate.at(i).size()) {
                        c = coordinate.at(i).at(j);
                        yCoordinate[i].push_back(c);
                        if ((j + 1) == coordinate.at(i).size()) {
                              max = true;
                              break;
                        }
                        ++j;
                  }
                  if (max) break;
                  while (coordinate.at(i).at(j) == ';' ||
                  coordinate.at(i).at(j) == ' ') {
                        if ((j + 1) == coordinate.at(i).size()) {
                              max = true;
                              break;
                        }
                        ++j;
                  }
                  
                  if (j < coordinate.at(i).size()) {
                        xCoordinate[i].push_back(' ');
                        yCoordinate[i].push_back(' ');
                  }
            }
      }
}