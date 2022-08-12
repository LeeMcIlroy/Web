package component.util;

import java.util.ArrayList;
import java.util.List;

public class ComAnalysisUtil {

	// 총합
	private static double sum(double[] data){
		double sum = 0;
		for(double d : data){
			sum += d;
		}
		return sum;
	}
	
	// 평균
	private static double average(double[] data){
		double avg = 0;
		double sum = sum(data);
		avg = sum/data.length;
		return avg;
	}
	
	// 편차의 제곱의 합
	private static double sumDeviation(double avg, double[] data){
		double sumDevi = 0;
		for(double d : data){
			sumDevi += Math.pow(d-avg, 2);
		}
		return sumDevi;
	}
	
	// x, y 의 편차 곱의 합
	private static double sumXYDeviationMultiply(double[] data_x, double data_x_avg, double[] data_y, double data_y_avg){
		double sumXYDeviMulti = 0;
		for(int i = 0; i < data_x.length; i++){
			sumXYDeviMulti += (data_x[i]-data_x_avg)*(data_y[i]-data_y_avg);
		}
		return sumXYDeviMulti;
	}
	
	// 회귀분석
	public static List<String> getRegressionAnalysis(double[] data_x, double[] data_y){
		List<String> resultList = null;
		
		if(data_x.length > 0 && data_y.length > 0 && data_x.length == data_y.length){
			resultList = new ArrayList<>();
			double data_x_avg = average(data_x);
			double data_y_avg = average(data_y);
			
			double data_x_sum_devi = sumDeviation(data_x_avg, data_x);
			//double data_y_sum_devi = sumDeviation(data_y_avg, data_y);
			
			double data_xy_sum_dev = sumXYDeviationMultiply(data_x, data_x_avg, data_y, data_y_avg);
			
			// y = ax + b + ε 단순선형회귀분석 그래프 방정식 (ε: 잔차, 잔차는 제외하고 계산)
			double a = 0;	// 기울기
			double b = 0;	// y 절편
			
			a = data_xy_sum_dev/data_x_sum_devi;
			b = data_y_avg-(data_x_avg*a);
			
			for(double d : data_x){
				resultList.add(String.format("%.2f", a*d+b));
			}
		}
		
		return resultList;
	}
}
