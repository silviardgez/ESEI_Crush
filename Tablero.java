// Environment code for project conecta4.mas2j

import jason.asSyntax.*;
import jason.environment.Environment;
import jason.environment.grid.GridWorldModel;
import jason.environment.grid.GridWorldView;
import jason.environment.grid.Location;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.util.Random;
import java.util.logging.Logger;

public class Tablero extends Environment {

    public static final int GSIZE = 10; // grid size

	//Steak codes in grid model
	public static final int[] STEAKCOLORS = {32,64,128,256,512,1024};
	
	//Create an array of colors
	public static final Color [] COLORS = {Color.blue,Color.red,Color.yellow,Color.green,Color.magenta,Color.cyan};

    private Logger logger = Logger.getLogger("conecta4.mas2j."+Tablero.class.getName());

    private TableroModel model;
    private TableroView  view;
    
    /** Called before the MAS execution with the args informed in .mas2j */
    @Override
    public void init(String[] args) {
        model = new TableroModel();
        view  = new TableroView(model);
        model.setView(view);
        //updatePercepts();
        super.init(args);
        addPercept(Literal.parseLiteral("percept(demo)"));
    }

    @Override
    public boolean executeAction(String ag, Structure action) {
        logger.info(ag+" doing: "+ action);
        try {
            if (action.getFunctor().equals("put")) {
                int x = (int)((NumberTerm)action.getTerm(0)).solve();
				int c = (int)((NumberTerm)action.getTerm(1)).solve();
                model.put(x,c);
			} else if (action.getFunctor().equals("intercambiarColores")) {
				int c1 = (int)((NumberTerm)action.getTerm(0)).solve();
				int x1 = (int)((NumberTerm)action.getTerm(1)).solve();
				int y1 = (int)((NumberTerm)action.getTerm(2)).solve();
				int c2 = (int)((NumberTerm)action.getTerm(3)).solve();
				int x2 = (int)((NumberTerm)action.getTerm(4)).solve();
				int y2 = (int)((NumberTerm)action.getTerm(5)).solve();
				model.intercambiarColores(c1,x1,y1,c2,x2,y2);
				
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
			Thread.sleep(100);
			
        } catch (Exception e) {}
        informAgsEnvironmentChanged();
        return true;
    }

    /** creates the agents perception based on the MarsModel */
    void updatePercepts() {
        clearPercepts();
        
        Location r1Loc = model.getAgPos(0);
        
        Literal pos1 = Literal.parseLiteral("pos(r1," + r1Loc.x + "," + r1Loc.y + ")");
        
        addPercept(pos1);
        
    }

    class TableroModel extends GridWorldModel {
        
        Random random = new Random(System.currentTimeMillis());

        private TableroModel() {
            super(GSIZE, GSIZE, 2);
            
            // initial location of agents
            try {
                setAgPos(0, 0, 0);
            
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        }
        
        void moveTowards(int x, int y) throws Exception {
            Location r1 = getAgPos(0);
			r1.x = r1.x + x - 1;
			r1.y = r1.y + y;
			if (r1.x < x)
                r1.x++;
            else if (r1.x > x)
                r1.x--;
            if (r1.y < y)
                r1.y++;
            else if (r1.y > y)
                r1.y--;
            setAgPos(0, r1);
            //setAgPos(1, getAgPos(1)); // just to draw it in the view
        }
		
        void put(int x, int c) throws Exception {
			Location r1 = new Location(0,0);
			r1.x = x - 1;
			r1.y = GSIZE - 1;
			
			for(int i=0;i<STEAKCOLORS.length;i++){
				while (hasObject(STEAKCOLORS[i],r1)) {
					r1.y--;
					i=0;
				}	
			}
			
			//if (isFree(r1.x, r1.y)==false) r1.y--;
			//setAgPos(0, r1);
			
			add(STEAKCOLORS[c],r1);
			addPercept(Literal.parseLiteral("steak(" + STEAKCOLORS[c] + "," + r1.x + "," + r1.y + ")"));
			System.out.println("Estoy añadiendo steak(" + STEAKCOLORS[c] + "," + r1.x + "," + r1.y + ")");

            //setAgPos(1, getAgPos(1)); // just to draw it in the view
        }
		
		
		
		void intercambiarColores(int color1, int x1, int y1, int color2, int x2, int y2)  throws Exception {
		
			set(color2, x1, y1);
			set(color1, x2, y2);
			
			//Remove old percepts
			removePercept(Literal.parseLiteral("steak(" + color1 + "," + x1 + "," + y1 + ")"));
			removePercept(Literal.parseLiteral("steak(" + color2 + "," + x2 + "," + y2 + ")"));
			
			//Add new percepts
			addPercept(Literal.parseLiteral("steak(" + color2 + "," + x1 + "," + y1 + ")"));
			addPercept(Literal.parseLiteral("steak(" + color1 + "," + x2 + "," + y2 + ")"));

		}
        
    }
    
    class TableroView extends GridWorldView {

        public TableroView(TableroModel model) {
            super(model, "Tablero", 400);
            //defaultFont = new Font("Arial", Font.BOLD, 18); // change default font
            setVisible(true);
            //repaint();
        }
		
		
        /** draw application objects */
        @Override
        public void draw(Graphics g, int x, int y, int object) {	

			for(int i = 0; i< Tablero.STEAKCOLORS.length;i++){
				if(Tablero.STEAKCOLORS[i] == object){
					drawSTEAK(g, x, y, COLORS[i]);
				}
			}
        }

        @Override
        public void drawAgent(Graphics g, int x, int y, Color c, int id) {
            //String label = "R"+(id+1);
            c = Color.white;
            //super.drawAgent(g, x, y, c, -1);
			//drawGarb(g, x, y);
		}
		
		public void drawSTEAK(Graphics g, int x, int y, Color c) {
			g.setColor(c);
			g.fillOval(x * cellSizeW + 2, y * cellSizeH + 2, cellSizeW - 4, cellSizeH - 4);
		}

        public void drawGarb(Graphics g, int x, int y) {
            super.drawObstacle(g, x, y);
            g.setColor(Color.blue);
            drawString(g, x, y, defaultFont, "G");
        }

    }    

    /** Called before the end of MAS execution */
    @Override
    public void stop() {
        super.stop();
    }
}

