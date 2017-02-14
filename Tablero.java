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

    public static final int GSize = 8; // grid size
    public static final int STEAK  = 16; // steak code in grid model

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
                model.put(x);
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        updatePercepts();

        try {
            Thread.sleep(200);
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
            super(GSize, GSize, 2);
            
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

        void put(int x) throws Exception {
            Location r1 = new Location(0,0);
			r1.x = x - 1;
			r1.y = 7;
            while (hasObject(STEAK,r1)) r1.y--;
			//if (isFree(r1.x, r1.y)==false) r1.y--;
			//setAgPos(0, r1);
			add(STEAK, r1);
            //setAgPos(1, getAgPos(1)); // just to draw it in the view
        }
        
    }
    
    class TableroView extends GridWorldView {

        public TableroView(TableroModel model) {
            super(model, "Tablero", 400);
            //defaultFont = new Font("Arial", Font.BOLD, 18); // change default font
            setVisible(true);
            //repaint();
        }

		//Create an array of colors
		Color [] colors = {Color.blue,Color.red,Color.yellow,Color.green,Color.magenta,Color.cyan};
		
		//Create random number to show colors
		Random rnd = new Random();
		
        /** draw application objects */
        @Override
        public void draw(Graphics g, int x, int y, int object) {
			//Select a random color
			Color c = colors[rnd.nextInt(colors.length)];
            switch (object) {
                case Tablero.STEAK: drawSTEAK(g, x, y, c);  break;
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
