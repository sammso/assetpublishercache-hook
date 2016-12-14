<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>
<%@ page import="com.liferay.portal.kernel.cache.SingleVMPoolUtil" %>
<%@ page import="com.liferay.portal.kernel.cache.PortalCache" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<portlet:defineObjects />
<liferay-theme:defineObjects />
<%
	String key = renderResponse.getNamespace();
	String cachedHtml = null;
	boolean isCache = GetterUtil.getBoolean(portletPreferences.getValue("iscache", "false"));
	
	PortalCache<String, String> cache = null;
	
	if ( isCache ) {
		cache = SingleVMPoolUtil.getCache("asset-publisher-cache");
		cachedHtml = cache.get(key);
	}
	
	if ( cachedHtml==null ) {
%>
<liferay-util:buffer var="html">
	<liferay-util:include
		page="/html/portlet/asset_publisher/view.portal.jsp" />
</liferay-util:buffer>
<%
		if (cache!=null) {
			cache.put(key,html);
		}
%><%=html %>
<%
	}
	else {
%><%=cachedHtml %><%
	}
%>