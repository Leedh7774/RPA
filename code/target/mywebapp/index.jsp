<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Injection Calculation</title>
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
        <h1 class="text-3xl py-4 border-b mb-10">Injection Calculation</h1>
        <form id="dataForm" action="/submit" method="POST">
            <div x-show="selectedRows.length" class="bg-teal-200 fixed top-0 left-0 right-0 z-40 w-full shadow">
                <div class="container mx-auto px-4 py-4">
                    <div class="flex md:items-center">
                        <div class="mr-4 flex-shrink-0">
                            <svg class="h-8 w-8 text-teal-600" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd"
                                      d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
                                      clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div x-html="selectedRows.length + ' rows are selected'" class="text-teal-800 text-lg"></div>
                    </div>
                </div>
            </div>
            <div class="overflow-x-auto bg-white rounded-lg shadow overflow-y-auto relative" style="height: 405px;">
                <table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-striped relative">
                    <thead>
                    <tr class="text-left">
                        <th class="py-2 px-3 sticky top-0 border-b border-gray-200 bg-gray-100">
                            <label class="text-teal-500 inline-flex justify-between items-center hover:bg-gray-200 px-2 py-2 rounded-lg cursor-pointer">
                                <input type="checkbox" class="form-checkbox focus:outline-none focus:shadow-outline"
                                       @click="selectAllCheckbox($event);">
                            </label>
                        </th>
                        <template x-for="heading in headings">
                            <th class="bg-gray-100 sticky top-0 border-b border-gray-200 px-6 py-2 text-gray-600 font-bold tracking-wider uppercase text-xs"
                                x-text="heading.value" :x-ref="heading.key" :class="{ [heading.key]: true }"></th>
                        </template>
                    </tr>
                    </thead>
                    <tbody>
                    <template x-for="(product, index) in products" :key="index">
                        <tr>
                            <td class="border-dashed border-t border-gray-200 px-3">
                                <label class="text-teal-500 inline-flex justify-between items-center hover:bg-gray-200 px-2 py-2 rounded-lg cursor-pointer">
                                    <input type="checkbox" class="form-checkbox rowCheckbox focus:outline-none focus:shadow-outline"
                                           :name="product.count" @click="getRowDetail($event, product.count)">
                                </label>
                            </td>
                            <td class="border-dashed border-t border-gray-200 count">
                                <span class="text-gray-700 px-6 py-3 flex items-center" x-text="product.count"></span>
                            </td>
                            <td class="border-dashed border-t border-gray-200 texture">
                                <input class="text-gray-700 px-6 py-3 flex items-center" placeholder="Product Name"
                                       name="productName[]" x-model="product.productName">
                            </td>
                            <td class="border-dashed border-t border-gray-200 texture">
                                <select class="text-gray-700 px-6 py-3 flex items-center" name="texture[]"
                                        x-model="product.texture" @change="updateSecondarySelect(product)">
                                    <option value="ABS">ABS</option>
                                    <option value="PP">PP</option>
                                    <option value="PE">PE</option>
                                    <option value="SAN">SAN</option>
                                </select>
                            </td>
                            <td class="border-dashed border-t border-gray-200 grade">
                                <select class="text-gray-700 px-6 py-3 flex items-center" name="grade[]"
                                        x-model="product.grade">
                                    <template x-for="option in getSecondaryOptions(product.texture)">
                                        <option :value="option.value" x-text="option.text"></option>
                                    </template>
                                </select>
                            </td>
                            <td class="border-dashed border-t border-gray-200 pweight">
                                <input class="text-gray-700 px-6 py-3 flex items-center" placeholder="Product Weight"
                                       name="productWeight[]" x-model="product.pweight" oninput="validateInput(event)">
                            </td>
                            <td class="border-dashed border-t border-gray-200 gender">
                                <input class="text-gray-700 px-6 py-3 flex items-center" placeholder="S/R Weight"
                                       name="srWeight[]" x-model="product.gender" oninput="validateInput(event)">
                            </td>
                            <td class="border-dashed border-t border-gray-200 cav">
                                <select class="text-gray-700 px-6 py-3 flex items-center" name="equipmentTonnage[]">
                                    <option>100</option>
                                    <option>120</option>
                                    <option>130</option>
                                    <option>150</option>
                                    <option>160</option>
                                    <option>170</option>
                                    <option>180</option>
                                    <option>200</option>
                                    <option>220</option>
                                    <option>240</option>
                                    <option>280</option>
                                    <option>380</option>
                                    <option>400</option>
                                </select>
                            </td>
                            <td class="border-dashed border-t border-gray-200 cav">
                                <input class="text-gray-700 px-6 py-3 flex items-center" placeholder="Number"
                                       name="equipmentNumber[]" x-model="product.cav" oninput="validateInput(event)">
                            </td>
                        </tr>
                    </template>
                    </tbody>
                </table>
            </div>
        </form>
        <div class="mb-4 flex justify-end">
            <div class="serchmargin">
                <button @click="addproduct" class="rounded-lg inline-flex items-center bg-white hover:text-blue-500 focus:outline-none focus:shadow-outline text-gray-500 font-semibold py-2 px-2 md:px-4">
                +</button>
                <button @click="removeSelected" class="rounded-lg inline-flex items-center bg-white hover:text-blue-500 focus:outline-none focus:shadow-outline text-gray-500 font-semibold py-2 px-2 md:px-4">
                -</button>
                <input type="button" onclick="submitForm()" class="rounded-lg inline-flex items-center bg-white hover:text-blue-500 focus:outline-none focus:shadow-outline text-gray-500 font-semibold py-2 px-2 md:px-4" value="send">
            </div>
        </div>
    <script>
        function datatables() {
            return {
                headings: [
                    {'key': 'count', 'value': 'Count'},
                    {'key': 'productName', 'value': 'ProductName'},
                    {'key': 'texture', 'value': 'Texture'},
                    {'key': 'grade', 'value': 'Grade'},
                    {'key': 'pweight', 'value': 'Product Weight'},
                    {'key': 'srWeight', 'value': 'S/R Weight'},
                    {'key': 'gender', 'value': 'Equipment Tonnage'},
                    {'key': 'cav', 'value': 'Cav.'}
                ],
                products: [{
                    "count": 1,
                    "productName": "",
                    "texture": "ABS",
                    "grade": "",
                    "pweight": "",
                    "srWeight": "",
                    "gender": "",
                    "cav": "100"
                }],
                selectedRows: [],

                addproduct() {
                    let newproduct = {
                        "count": this.getCount(),
                        "productName": "",
                        "texture": "ABS",
                        "grade": "",
                        "pweight": "",
                        "srWeight": "",
                        "gender": "",
                        "cav": "100"
                    };
                    this.products.push(newproduct);
                },

                getCount() {
                    let maxCount= 0;
                    this.products.forEach(product => {
                        if (product.count > maxCount) {
                            maxCount = product.count;
                        }
                    });
                    return maxCount + 1;
                },

                getSecondaryOptions(selectedTexture) {
                    switch (selectedTexture) {
                        case 'ABS':
                            return [
                                {value: 'HF380', text: 'HF380'},
                                {value: 'HI121', text: 'HI121'},
                                {value: 'SG175', text: 'SG175'},
                            ];
                        case 'PP':
                            return [
                                {value: '344RK', text: '344RK'},
                                {value: '4017', text: '4017'},
                                {value: 'J-550A', text: 'J-550A'},
                                {value: 'J-560S', text: 'J-560S'},
                            ];
                        case 'PE':
                            return [
                                {value: 'M850', text: 'M850'},
                                {value: '5321', text: '5321'},
                                {value: 'JXJ700', text: 'XJ700'},
                            ];
                        case 'SAN':
                            return [
                                {value: '80HF', text: '80HF'},
                                {value: '82TR', text: '82TR'},
                            ];
                        default:
                            return [];
                    }
                },

                updateSecondarySelect(product) {
                    product.grade = ""; // Reset grade when texture changes
                },

                toggleColumn(key) {
                    let columns = document.querySelectorAll('.' + key);
                    if (this.$refs[key].classList.contains('hidden') && this.$refs[key].classList.contains(key)) {
                        columns.forEach(column => {
                            column.classList.remove('hidden');
                        });
                    } else {
                        columns.forEach(column => {
                            column.classList.add('hidden');
                        });
                    }
                },

                getRowDetail($event, id) {
                    let rows = this.selectedRows;

                    if (rows.includes(id)) {
                        let index = rows.indexOf(id);
                        rows.splice(index, 1);
                    } else {
                        rows.push(id);
                    }
                },

                selectAllCheckbox($event) {
                    let columns = document.querySelectorAll('.rowCheckbox');

                    this.selectedRows = [];

                    if ($event.target.checked) {
                        columns.forEach(column => {
                            column.checked = true;
                            this.selectedRows.push(parseInt(column.name));
                        });
                    } else {
                        columns.forEach(column => {
                            column.checked = false;
                        });
                        this.selectedRows = [];
                    }
                },

                removeSelected() {
                    let rowsToDelete = this.selectedRows;
                    this.products = this.products.filter(product => !rowsToDelete.includes(product.count));
                    this.selectedRows = [];
                }
            };
        }
        function validateInput(event) {
            const input = event.target;
            const validValue = input.value.replace(/[^0-9.]/g, '');
            const parts = validValue.split('.');
            if (parts.length > 2) {
                input.value = parts[0] + '.' + parts.slice(1).join('');
            } else {
                input.value = validValue;
            }
        }
        function submitForm() {
            let NameInputs = document.getElementsByName('productName[]');
            let PweightInputs = document.getElementsByName('productWeight[]');
            let SweightInputs = document.getElementsByName('srWeight[]');
            let hasEmptyField = false;

            for (let i = 0; i < NameInputs.length; i++) {
                let NameValue = NameInputs[i].value.trim();
                let PweightValue = PweightInputs[i].value.trim();
                let SweightValue = SweightInputs[i].value.trim();

                if (NameValue === "" || PweightValue === "" || SweightValue === "") {
                    hasEmptyField = true;
                    break;
                }
            }

            if (hasEmptyField) {
                alert("There is a null value.");
            } else {
                return document.getElementById("dataForm").submit();
            }
        }

    </script>
</body>
</html>
