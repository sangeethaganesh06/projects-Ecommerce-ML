<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Newspaper Cellulose Calculations</title>
    <style>
             body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
    }
        h1 {
            color: #333;
            text-align: center;
        }
        .calculation-inputs {
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            width: 60%;
            margin: 20px auto;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: relative;
        }
        .calculation-inputs input, .calculation-inputs button {
            margin: 5px;
            padding: 10px;
            border: 1px solid #ddd;
        }
        .calculation-inputs button.submit {
            position: absolute;
            right: 10px;
            bottom: 10px;
        }
        .result {
            margin: 20px 0;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            width: 60%;
            margin: 20px auto;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .result p {
            margin: 10px 0;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
             margin-left: 10%;
            margin-top: 5%;
        }
        button:hover {
            background-color: #45a049;
        }
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
             padding-top: 60px; 
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%; 
             position: relative;
        }
        .close {
              color: #aaa;
            position: absolute;
            top: 10px;
            right: 25px;
            font-size: 35px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .btn-animated {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .btn-animated:hover {
            transform: scale(1.1);
        }
        .btn-animated:active {
            transform: scale(1);
        }
    </style>
    <script>
    function calculateMixRatio() {
        var weightCellulose = parseFloat(document.getElementById("weightCellulose").value);
        var weightHusk = parseFloat(document.getElementById("weightHusk").value);
        if (!isNaN(weightCellulose) && !isNaN(weightHusk) && weightHusk > 0) {
            var mixRatio = weightCellulose / weightHusk;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Mix Ratio Calculation</h2>" +
                "<p>Weight of Newspaper Cellulose: " + weightCellulose + " grams</p>" +
                "<p>Weight of Rice Husk: " + weightHusk + " grams</p>" +
                "<p>Mix Ratio: " + mixRatio.toFixed(2) + " (Newspaper Cellulose : Rice Husk)</p>" +
                "<form id='testForm' action='SubmitCelluloseTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='Cellulose'>" +
                "<input type='hidden' name='weightCellulose' value='" + weightCellulose + "'>" +
                "<input type='hidden' name='weightHusk' value='" + weightHusk + "'>" +
                "<input type='hidden' name='mixRatio' value='" + mixRatio + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for both weight values.");
        }
    }

    function calculateDensity() {
        var totalWeight = parseFloat(document.getElementById("totalWeight").value);
        var volume = parseFloat(document.getElementById("volume").value);
        if (!isNaN(totalWeight) && !isNaN(volume) && volume > 0) {
            var density = totalWeight / volume;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Density Calculation</h2>" +
                "<p>Total Weight: " + totalWeight + " kg</p>" +
                "<p>Volume: " + volume + " m³</p>" +
                "<p>Density: " + density.toFixed(2) + " kg/m³</p>" +
                "<form id='testForm' action='SubmitCelluloseTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='Density'>" +
                "<input type='hidden' name='totalWeight' value='" + totalWeight + "'>" +
                "<input type='hidden' name='volume' value='" + volume + "'>" +
                "<input type='hidden' name='density' value='" + density + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for both weight and volume values.");
        }
    }

    function openModal() {
        document.getElementById("myModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("myModal").style.display = "none";
    }
    </script>
</head>
<body>
    <button class="btn-animated" onclick="window.location.href='material_types.jsp?material=<%= request.getParameter("material") %>'">Back</button>

   
 <h1>NEWS PAPER CELLULOSE CALCULATION </h1><br>
 
    <div class="calculation-inputs">
        <h2>Mix Ratio Calculation</h2>
        <input type="number" id="weightCellulose" step="0.01" placeholder="Weight of Newspaper Cellulose (grams)">
        <input type="number" id="weightHusk" step="0.01" placeholder="Weight of Rice Husk (grams)">
        <button class="btn-animated" type="button" onclick="calculateMixRatio()">Calculate Mix Ratio</button>
    </div>

    <div class="calculation-inputs">
        <h2>Density Calculation</h2>
        <input type="number" id="totalWeight" step="0.01" placeholder="Total Weight (kg)">
        <input type="number" id="volume" step="0.01" placeholder="Volume (m³)">
        <button class="btn-animated" type="button" onclick="calculateDensity()">Calculate Density</button>
    </div>

    <!-- Modal for displaying results -->
    <div id="myModal" class="modal">
        <div class="modal-content" id="modalContent">
            <!-- Modal content will be populated by JavaScript -->
        </div>
    </div>
</body>
</html>
