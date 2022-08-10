package component.util;

import java.util.Random;

public class ComStringUtil {
	
	public static String createPassword(int length){
		Random random = new Random();
		StringBuffer newPassword = new StringBuffer();
		for ( int i = 0; i < length; i++ ) {
			if ( random.nextBoolean() ) {
				newPassword.append(String.valueOf((char)((int)(random.nextInt(26))+97)));
			} else {
				newPassword.append((random.nextInt(10)));
			}
		}
		return newPassword.toString();
	}

}
