// A simple Java sample application which displays a few messages based
// upon the Chaperone environment.

import java.util.Map;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class SampleApp {

    // Shortcut for printing
    static void pr(String s) {
	System.out.println(s);
    }

    // shell("cmd") will execute a command in a shell and return its output
    static String shell(String cmd) {
	Process p;
	StringBuffer sb = new StringBuffer();

	try {
	    p = Runtime.getRuntime().exec(cmd);
	    p.waitFor();

	    BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
	    String line = "";
	    while ((line = reader.readLine()) != null) {
		sb.append(line + "\n");
	    }
	} catch (Exception e) {
	    pr("Couldn't execute shell command: " + cmd);
	}
	
	return sb.toString();
    }

    public static void main(String[] args) {
	Map<String, String> env = System.getenv();
	String apps_dir = env.get("APPS_DIR");
	String user = env.get("USER");

	pr("");
	pr("********************");
	pr("NOTE: This is output from " + apps_dir + "/java_sample/SampleApp.class");
	pr("      (A Java user application sample.)");
	pr("");
	pr("You can disable this application, or replace it with your own by examining");
	pr("the " + apps_dir + "/chaperone.d/200-userapp.conf configuration file.");
	pr("");

	if (!user.equals("runapps")) {
	    pr("Your container is running as user '" + user + "'.  This most likely means that your");
	    pr("application directory is shared with your host for easy development.");
	} else {
	    pr("Your container is running as '" + user + "'.  This looks like a production environment");
	    pr("and all configuration is stored within the container's filesystem.");
	}

	// See if there is a console app running...
	String status = shell("bash -c \"telchap status | awk '/CONSOLE/{print $4}'\"");

	if (!status.equals("starting")) {
	    String interactive = env.get("INTERACTIVE");
	    pr("");
	    if (interactive != null && interactive.equals("1")) {
		pr("You're running interactively, but there is no console application.  Perhaps");
		pr("you should add /bin/bash to the 'docker run' command line?");
		pr("");
	    } else {
		pr("Because there is no foreground application, the system may appear to hang,");
		pr("but it's running.  You can type Ctrl-C to stop it.");
	    }
	} else {
	    pr("There is no foreground application.  Ctrl-C will stop the system, or you");
	    pr("can get in using 'docker exec container-name /bin/bash");
	}

	pr("");
	pr("********************");
    }
}
