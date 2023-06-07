class Problem{ //problem class is java class for making problem and check the answer.
  String problem;
  boolean answer;
  Problem(String pro, boolean ans){
    problem = pro;
    answer = ans;
  }
  boolean checkAnswer(boolean ans){//Funtion to check the answer
    if(answer == ans){
      return true;
    }
    else{
      return false;
    }
  }
}
