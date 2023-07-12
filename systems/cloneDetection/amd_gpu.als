package mualloy;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4.ErrorWarning;
import edu.mit.csail.sdg.ast.Command;
import edu.mit.csail.sdg.parser.CompModule;
import edu.mit.csail.sdg.parser.CompUtil;
import edu.mit.csail.sdg.translator.A4Options;
import edu.mit.csail.sdg.translator.A4Solution;
import edu.mit.csail.sdg.translator.TranslateAlloyToKodkod;
import parser.etc.Names;
import parser.util.AlloyUtil;

public class executeAlloyModel {


	public static void main(String[] args) throws IOException {
 
    //specifying the directory where the model is located
		String directory = "models/finalCombined/cloneDetection/";
		File modelDir = new File(directory);

		File[] modelFiles = modelDir.listFiles((d, name) -> name.endsWith(Names.DOT_ALS));
   
    //in case we need to save the solutions
	//	ArrayList<String> solutions = new ArrayList<>();

  //ignore this, i've wrote this down so i can see which models are compiling and which are not
	//	FileWriter writer = new FileWriter("src/solutionSatisfiable.txt");
	//	FileWriter writers = new FileWriter("src/solutionUnsatisfiable.txt");

		for (File file : modelFiles) {
      //going through each of the files			
      String file_name_submission = directory + file.getName();
			A4Reporter rep = new A4Reporter() {
				@Override
				public void warning(ErrorWarning msg) {
					System.out.println(msg.toString().trim());
					System.out.flush();
				}
			};

			CompModule submissionWorld;

			try {
        //specifying the file that is parsing
				submissionWorld = CompUtil.parseEverything_fromFile(rep, null, file_name_submission);
				//saves all commands that are located in the model
				for (int i = 0; i < submissionWorld.getAllCommands().size(); i++) {
					Command commandSubmission = submissionWorld.getAllCommands().get(i);
					A4Options options = new A4Options();
					options.solver = A4Options.SatSolver.SAT4J;
					String instance;
					try {
						A4Solution instanceSubmission = TranslateAlloyToKodkod.execute_command(rep,
								submissionWorld.getAllReachableSigs(), commandSubmission, options);
            //this is the actual line of code that we'll need to change
                 //currently it's printing the input for KodKod
						instance = instanceSubmission.debugExtractKInput(); 
						System.out.println(instance);
						System.out.println("----------- ");
					} catch (Err e) {
						continue;
					}
			//		solutions.add(instance);
				}
			} catch (Err e1) {
				e1.printStackTrace();
			}
		}
	//	for (String string : solutions) {
	//		writer.write(string + System.lineSeparator());
	//	}
	//	writer.close();
	//	writers.close();
	}

}
