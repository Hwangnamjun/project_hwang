package service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class weather {
	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = nlList.item(0);
		return nValue == null ? null : nValue.getNodeValue();
	}

	public List<String> checkWeather() throws Exception {
		List<String> weatherList = new ArrayList();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat format2 = new SimpleDateFormat("kk");
		Date date1 = new Date();
		Date yesterday = new Date(date1.getTime() - 86400000L);
		String yesterdayDate = format1.format(yesterday);
		String yesterdayTime = format2.format(date1);
		String servicekey = "r%2BD0%2Fv%2B%2B%2FWlLiuw%2BinaJu18b%2FUgIdoTqbmxYj4OHEKxqkXfX%2Fu4y6TPjSLAi5e2acxj1vM7OTLRAyckCFdXbiw%3D%3D";
		String url = "http://apis.data.go.kr/1360000/AsosHourlyInfoService/getWthrDataList?serviceKey=" + servicekey
				+ "&pageNo=1&numOfRows=10&dataType=XML&dataCd=ASOS&dateCd=HR&startDt=" + yesterdayDate + "&startHh="
				+ yesterdayTime + "&endDt=" + yesterdayDate + "&endHh=" + yesterdayTime + "&stnIds=159&";
		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
		Document doc = dBuilder.parse(url);
		doc.getDocumentElement().normalize();
		NodeList nList = doc.getElementsByTagName("item");

		for (int temp = 0; temp < nList.getLength(); ++temp) {
			Node nNode = nList.item(temp);
			if (nNode.getNodeType() == 1) {
				Element eElement = (Element) nNode;
				weatherList.add(getTagValue("tm", eElement));
				weatherList.add(getTagValue("ta", eElement));
				weatherList.add(getTagValue("ws", eElement));
				weatherList.add(getTagValue("rn", eElement));
				weatherList.add(getTagValue("hm", eElement));
			}
		}

		return weatherList;
	}
}