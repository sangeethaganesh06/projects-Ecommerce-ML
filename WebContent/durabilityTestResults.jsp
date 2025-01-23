<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Materials List</title>
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
        table {
            width: 70%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            background-color: #fff;
         
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
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
</head>
<body>
 <button class="btn-animated" onclick="window.location.href='PerformanaceEfficiencyPage.jsp'">Back</button>
    <h1>MATERIALS IN RICEHUSK INSULATION</h1>
    <br>    <br>    <br>
       
    <form action="ViewMaterialServlet" method="post">
       <center> <table>
            <thead>
                <tr>
                    <th>Material Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Binder</td>
                    <td><button class="btn-animated" type="submit" name="material" value="Binder">View</button></td>
                </tr>
                <tr>
                    <td>NewsPaperCellulose</td>
                    <td><button class="btn-animated" type="submit" name="material" value="NewsPaper Cellulose">View</button></td>
                </tr>
               
                <tr>
                    <td>MoistureControlAgent</td>
                    <td><button class="btn-animated" type="submit" name="material" value="MoistureControlAgent">View</button></td>
                </tr>
                <tr>
                    <td>ThermalConductivityEnhancer</td>
                    <td><button class="btn-animated" type="submit" name="material" value="ThermalConductivityEnhancer">View</button></td>
                </tr>
                <!-- Add more rows for additional materials if needed -->
            </tbody>
        </table>
        </center>
    </form>
</body>
</html>

