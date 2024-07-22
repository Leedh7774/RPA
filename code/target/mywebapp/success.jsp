<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Injection Result</title>
    <link rel="dns-prefetch" href="//unpkg.com">
    <link rel="dns-prefetch" href="//cdn.jsdelivr.net">
    <link rel="stylesheet" href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css">
    <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.js" defer></script>
    <style>
        [x-cloak] {
            display: none;
        }
        /* input:checked + svg {
        display: block;
        } */
        [type="checkbox"] {
            box-sizing: border-box;
            padding: 0;
        }

        .form-checkbox {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            -webkit-print-color-adjust: exact;
            color-adjust: exact;
            display: inline-block;
            vertical-align: middle;
            background-origin: border-box;
            -webkit-product-select: none;
            -moz-product-select: none;
            -ms-product-select: none;
            product-select: none;
            flex-shrink: 0;
            color: currentColor;
            background-color: #fff;
            border-color: #e2e8f0;
            border-width: 1px;
            border-radius: 0.25rem;
            height: 1.2em;
            width: 1.2em;
        }

        .form-checkbox:checked {
            background-image: url("data:image/svg+xml,%3csvg viewBox='0 0 16 16' fill='white' xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M5.707 7.293a1 1 0 0 0-1.414 1.414l2 2a1 1 0 0 0 1.414 0l4-4a1 1 0 0 0-1.414-1.414L7 8.586 5.707 7.293z'/%3e%3c/svg%3e");
            border-color: transparent;
            background-color: currentColor;
            background-size: 100% 100%;
            background-position: center;
            background-repeat: no-repeat;
        }

        .serchmargin {
            margin: 10px 0px 0px 5px;
        }

        td > input {
            width: 80%;
            font-size: 15px;
        }

        select {
            font-size: 15px;
        }
    </style>
</head>

<body class="antialiased sans-serif bg-gray-200">
    <div class="container mx-auto py-6 px-4" x-data="datatables()" x-cloak>
        <h1 class="text-3xl py-4 border-b mb-10">Injection Result</h1>
        <form id="dbForm" action="/result" method="POST">
            <div class="overflow-x-auto bg-white rounded-lg shadow overflow-y-auto relative" style="height: 405px;">
                <table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-striped relative">
                    <thead>
                        <tr class="text-left">
                            <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xs">Count</th>
                            <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xs">Product Name</th>
                            <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xs">Total Weight</th>
                            <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xs">Material Price</th>
                            <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xs">Total Money</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String[] productNames = (String[]) request.getAttribute("productNames");
                            String[] textures = (String[]) request.getAttribute("textures");
                            String[] grades = (String[]) request.getAttribute("grades");
                            String[] productWeights = (String[]) request.getAttribute("productWeights");
                            String[] srWeights = (String[]) request.getAttribute("srWeights");
                            String[] equipmentTonnages = (String[]) request.getAttribute("equipmentTonnages");
                            String[] equipmentNumbers = (String[]) request.getAttribute("equipmentNumbers");
                        %>
                        <% 
                            String materialPrice = "";
                            for (int i = 0; i < productNames.length; i++) { 
                                double productWeight = Double.parseDouble(productWeights[i]);
                                double srWeight = Double.parseDouble(srWeights[i]);
                                int equipmentNumber = Integer.parseInt(equipmentNumbers[i]);
                                double totalWeight = (productWeight + srWeight) / equipmentNumber;
                                double totalWeightKg = totalWeight/1000.0;
                                String formattedWeight = String.format("%.2f", totalWeight);

                                if ("HF380".equals(grades[i]) || "SG175".equals(grades[i])) {
                                    materialPrice = "2600";
                                } else if ("344RK".equals(grades[i]) || "4017".equals(grades[i]) || "J-560S".equals(grades[i])) {
                                    materialPrice = "1600";
                                } else if ("J-550A".equals(grades[i]) || "J-560S".equals(grades[i])) {
                                    materialPrice = "1800";
                                } else if ("M850".equals(grades[i])) {
                                    materialPrice = "1700";
                                } else if ("5321".equals(grades[i]) || "XJ700".equals(grades[i])) {
                                    materialPrice = "2100";
                                } else if ("80HF".equals(grades[i]) || "82TR".equals(grades[i])) {
                                    materialPrice = "2300";
                                } else if ("HI121".equals(grades[i])){
                                    materialPrice = "2400";
                                } else if ("J-550A".equals(grades[i])){
                                    materialPrice = "1800";
                                } else {
                                    materialPrice = "";
                                }
                                if (!materialPrice.isEmpty()) {
                                    double totalMoney = totalWeightKg * Double.parseDouble(materialPrice);
                                    String formattedMoney = String.format("%.2f", totalMoney);
                        %>
                            <tr>
                                <td class="border-dashed border-t border-gray-200 text-gray-700 px-6 py-3"><%= i+1 %></td>
                                <td class="border-dashed border-t border-gray-200 text-gray-700 px-6 py-3"><%= productNames[i] %></td>
                                <td class="border-dashed border-t border-gray-200 text-gray-700 px-6 py-3"><%= formattedWeight %></td>
                                <td class="border-dashed border-t border-gray-200 text-gray-700 px-6 py-3"><%= materialPrice %></td>
                                <td class="border-dashed border-t border-gray-200 text-gray-700 px-6 py-3"><%= formattedMoney %></td>
                            </tr>
                            <input type="hidden" name="productNames" value="<%= productNames[i] %>">
                            <input type="hidden" name="totalWeights" value="<%= formattedWeight %>">
                            <input type="hidden" name="materialPrices" value="<%= materialPrice %>">
                            <input type="hidden" name="totalMoneys" value="<%= formattedMoney %>">
                            <input type="hidden" name="textures" value="<%= textures[i] %>">
                            <input type="hidden" name="grades" value="<%= grades[i] %>">
                            <input type="hidden" name="productWeights" value="<%= productWeights[i] %>">
                            <input type="hidden" name="srWeights" value="<%= srWeights[i] %>">
                            <input type="hidden" name="equipmentTonnages" value="<%= equipmentTonnages[i] %>">
                            <input type="hidden" name="equipmentNumbers" value="<%= equipmentNumbers[i] %>">
                        <% 
                            }
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </form>
        <div class="mb-4 flex justify-end">
            <div class="serchmargin">
                <input type="button" onclick="window.location.href='/index.jsp'" class="rounded-lg inline-flex items-center bg-white hover:text-blue-500 focus:outline-none focus:shadow-outline text-gray-500 font-semibold py-2 px-2 md:px-4" value="back">
                <input type="button" onclick="submitForm()" class="rounded-lg inline-flex items-center bg-white hover:text-blue-500 focus:outline-none focus:shadow-outline text-gray-500 font-semibold py-2 px-2 md:px-4" value="send">
            </div>
        </div>
    <script>
        function datatables() {
            return {
            };
        }

        function submitForm() {
            document.getElementById('dbForm').submit();
            alert("Success send to Oralce database.");
        }
    </script>
</body>
</html>
