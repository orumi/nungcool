package exam.com.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by owner1120 on 2016-01-29.
 */
public class ComIdCreator {

    public static synchronized String getNowTime (int selection) {

        String wtime;

        java.util.Date now = new java.util.Date();
        SimpleDateFormat vans = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String odate = vans.format(now);

        switch (selection){
            case 2 :
                wtime = odate.substring(11,13);
                break;
            case 4 :
                wtime = odate.substring(11,13) + odate.substring(14,16);
                break;
            case 6 :
                wtime = odate.substring(11,13) + odate.substring(14,16) + odate.substring(17, 19);
                break;
            default:
                wtime = odate.substring(11,13) + odate.substring(14,16);
        }
        return wtime;
    }

    public static synchronized String getToday(){

        Calendar cal = Calendar.getInstance();

        String year = Integer.toString(cal.get(Calendar.YEAR));
        String month = Integer.toString((cal.get(Calendar.MONTH)) + 1);
        if (month.length() == 1) month = "0" + month;
        String day = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
        if (day.length() == 1) day = "0" + day; // 한자리 일자인 경우 보정

        return year + month + day;

    }


}
