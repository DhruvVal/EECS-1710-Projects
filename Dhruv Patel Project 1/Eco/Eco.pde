int BUG_COUNT = 25;
int MAX_FOOD = 50;
int FOOD_SPAWN_RATE = 30;
int time_for_new_food = FOOD_SPAWN_RATE;

ArrayList<Bug> bugs, new_born, dead_bugs;
ArrayList<Food> foods;

void setup()
{
  size(700,700);
  
  bugs = new ArrayList<Bug>();
  new_born = new ArrayList<Bug>();
  dead_bugs = new ArrayList<Bug>();
  foods = new ArrayList<Food>();
 
  
  for(int i = 0; i < BUG_COUNT; i++)
  {
    bugs.add(new Bug());  
  }
  
  for(int i = 0; i < MAX_FOOD; i++)
  {
    foods.add(new Food());  
  }
}

void draw()
{
  background(#BFBFBF);
  
  // update current population
  for(Food f : foods)
  {
      f.draw();  
  }
  
  for(Bug b : bugs)
  {
      b.update(foods, bugs);
      if(isBugDead(b))
        dead_bugs.add(b);
      else
        b.draw();  
  }
  
  // update ecosystem population for next iteration
  for(Bug nb : new_born)
    bugs.add(nb);
  
  for(Bug db : dead_bugs)
    bugs.remove(db);
  
  dead_bugs.clear();
  new_born.clear();
  
  //spawn new food
  if(foods.size() != MAX_FOOD)
  {
      if(time_for_new_food == 0)
      {
         foods.add(new Food()) ;
         time_for_new_food = FOOD_SPAWN_RATE;
      }
      else
        time_for_new_food--;
  }
}

class Food
{
    PVector loc;
    float SIZE = 10; 
    color c = #ED9A35;
    
    Food()
    {
      loc = new PVector();
      loc.x = random(width);
      loc.y = random(height);
    }
    
    void draw()
    {
      fill(#ED9A35);
      rect(loc.x, loc.y, SIZE,SIZE);
    }
}

boolean isBugDead(Bug b)
{
    if(b.hunger >= 1 || b.age >= 1) //<>//
    {
      print("died " + b.hunger + " " + b.age + "\n");
      return true;
    }
        
    else
        return false;
}

class Bug
{
    //conts
    float SIZE = 15;
    int MATING_DURATION = 60;
    
    //genetic params
    float starve_rate;
    float aging_rate;
    float perception_range; //
    float mating_desire_rate;

    float hunger = 0; // between 0-1 if hunger is 1 the bug dies, increases over time and reduces with food
    float age = 0.25; // between 0-1 if age is 1 the bug dies cause of old age
    float gender; //0-male 1-female,
    float speed = 3;
    float size;
    float mating_desire = 0; // between 0-1 more desire means reproducing has more priority, increases over time and reduces after having ***
    
    int mating_counter = 0;
    
    PVector loc;
    PVector waypoint;
    color c;
    
    Bug target_mate;
    Food target_food;
    
    boolean mating = false;
    boolean starving = false;
    boolean adult;
    
    Bug()
    {
        // determihe gender and gender color
        if(random(1) < 0.5)
        {
          gender = 0;
          c = #6180EA;
        }
        else
        {
          gender = 1;
          c = #EA61E8;          
        }
        
        loc = new PVector();
        loc.x = random(width);
        loc.y = random(height);
        adult = true;
        setRandomWaypoint();
        size = SIZE;
        
        aging_rate = 0.001;
        // set random gene params
        starve_rate = random(0.0035,0.0045);
        perception_range = random(100,150);
        mating_desire_rate = random(0.0015, 0.003);
    }

    void update(ArrayList<Food> foods, ArrayList<Bug> bugs)
    {   
       //status update
       hunger += starve_rate;
       mating_desire += mating_desire_rate;
       age += aging_rate;
       
       if(age > 0.15)
       {
          adult = true;    
          size = SIZE; // make bug big after it becomes adult
       }      
       
      if(hunger > 0.55)
      {
         starving = true;
      }
      else if(canMate())
      {
          target_mate = lookForMate(bugs);
          
          if(target_mate != null)
          {
             mating = true;
             target_mate.mating = true;
          }
      }
       
       if(mating) 
       {
         //if mate is in range begin mating if not seek the mate
          if(loc.dist(target_mate.loc) < 5)
          {
             waypoint = new PVector(-1,-1);
             if(mating_counter != MATING_DURATION) // during mating both bugs must stay remain for few moments
             {
                mating_counter++;
             }
             else // mating completed, born new bug 
             {
                Bug new_bug = bornNewBug(target_mate);
                new_born.add(new_bug);
                mating_counter = 0; 
                mating = false;
                mating_desire = 0;
                target_mate = null;
                
                setRandomWaypoint();
             }
          }
          else // seek the mate
            waypoint = target_mate.loc;
       }
       else if(starving) // if starving seek for food is there is no food range go for random location
       {
          target_food = getNearestFood(foods);
            
          // check if we eat if eats remove the food and make hunger zero
          if(target_food != null && loc.dist(target_food.loc) < 3)
          {
            foods.remove(target_food);
            hunger = 0;
            starving = false;
          }
          else if(target_food != null)
            waypoint = target_food.loc; //<>//
          else
          {
            if(loc.dist(waypoint) < 3)
            {
                setRandomWaypoint();
            }
          }
          
       }
       // random random waypoint if not starving or mating
        else
        {
          if(loc.dist(waypoint) < 3)
          {
              setRandomWaypoint();
          }
        }
        
       
        //moving 
       if(waypoint.x != -1)
       {
         PVector dir = waypoint.copy().sub(loc).normalize();
         loc.add(dir.mult(speed));       
         
          if(loc.dist(waypoint) < 3)
          {
              setRandomWaypoint();
          }
       } //<>//
       
    }
    
    Food getNearestFood(ArrayList<Food> foods)
    {
       Food closest_food = null;
       float min_dis = width * height;
       
       for(Food f : foods)
       {
           float d = loc.dist(f.loc);
           if(d < min_dis && d <= perception_range)
           {
              closest_food = f;
              min_dis = d;
           }
       }
       
       return closest_food;
    }
    
    Bug lookForMate(ArrayList<Bug> bugs)
    {
      for(Bug b : bugs)
      {
         float d = loc.dist(b.loc);
         // ask for mate if both are seeing eachother and they are not same gender
         // if other accepts mating then return the target_mate;
         if(d < perception_range && d < b.perception_range && b.gender != gender)
         {
            if(askForMating(b))
            {
             b.target_mate = this; 
             return b;
            }
         }
      }
      
      return null;
    }
    
    // born new bug with combination of parents genes
    Bug bornNewBug(Bug mate)
    {
        Bug new_bug = new Bug();
        
        new_bug.loc.x = loc.x;
        new_bug.loc.y = loc.y;
        new_bug.size = SIZE / 2; // new born have smaller size
        new_bug.age = 0;
        new_bug.adult = false;
        
        //migrating genetic params
        new_bug.starve_rate = selectGene(starve_rate, mate.starve_rate);
        new_bug.perception_range = selectGene(perception_range, mate.perception_range);
        new_bug.mating_desire_rate = selectGene(perception_range, mate.perception_range);
        
        return new_bug;
    }
    
    // during mating this function select selected gene from one of its parent
    float selectGene(float gene1, float gene2)
    {
      if(random(1) < 0.5)
        return gene1;
      else
        return gene2;
    }
    
    boolean canMate()
    {
       if(mating_desire > hunger && target_mate == null && adult)
         return true;
       else
         return false;
    }
    
    boolean askForMating(Bug b)
    {
       return b.canMate(); 
    }
    
    void setRandomWaypoint()
    {
      waypoint = new PVector();
      waypoint.x = random(width);
      waypoint.y = random(height);
    }

    void draw()
    {
      fill(c);
      ellipse(loc.x, loc.y, size, size);  
    }
}
