<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="footer">

</div>

<script>
    const date = new Date();
    const footer = document.getElementById("footer");
    footer.innerHTML = "<p>&copy" + date.getFullYear() + "&nbsp; HRDKOREA All right reserverd. </p>";
</script>