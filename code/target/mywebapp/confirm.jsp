<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Confirmation Page</title>
</head>
<body>
    <h1>Confirmation Page</h1>
    <div class="container">
        <table border="1">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Total Weight</th>
                    <th>Material Price</th>
                    <th>Total Money</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String[] productNames = (String[]) request.getAttribute("productNames");
                    String[] totalWeights = (String[]) request.getAttribute("totalWeights");
                    String[] materialPrices = (String[]) request.getAttribute("materialPrices");
                    String[] totalMoneys = (String[]) request.getAttribute("totalMoneys");

                    if (productNames != null) {
                        for (int i = 0; i < productNames.length; i++) {
                %>
                            <tr>
                                <td><%= productNames[i] %></td>
                                <td><%= totalWeights[i] %></td>
                                <td><%= materialPrices[i] %></td>
                                <td><%= totalMoneys[i] %></td>
                            </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>