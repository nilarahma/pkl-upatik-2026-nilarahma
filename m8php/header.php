<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Sistem Informasi Siswa</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 40px 20px; }
        .container { max-width: 1100px; margin: 0 auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 20px 60px rgba(0,0,0,0.3); }
        .header-title { text-align: center; color: #2c3e50; font-size: 28px; margin-bottom: 5px; }
        .header-subtitle { text-align: center; color: #7f8c8d; font-size: 16px; margin-bottom: 30px; }
        .header-divider { border: none; height: 3px; background: linear-gradient(to right, #667eea, #764ba2); margin-bottom: 25px; border-radius: 3px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-bottom: 30px; }
        .stat-box { background: #f8f9fa; padding: 15px; border-radius: 10px; text-align: center; border-left: 4px solid #667eea; }
        .stat-box .number { font-size: 28px; font-weight: bold; color: #2c3e50; }
        .stat-box .label { color: #7f8c8d; font-size: 14px; margin-top: 5px; }
        .stat-box .number.green { color: #27ae60; }
        .stat-box .number.red { color: #e74c3c; }
        .stat-box .number.blue { color: #3498db; }
        .stat-box .number.orange { color: #f39c12; }
        .table-wrapper { overflow-x: auto; margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; border-radius: 8px; overflow: hidden; }
        thead { background: #2c3e50; color: white; }
        th { padding: 14px 16px; text-align: left; font-weight: 600; }
        td { padding: 12px 16px; border-bottom: 1px solid #ecf0f1; }
        tbody tr:hover { background: #f8f9fa; }
        .grade { display: inline-block; padding: 4px 12px; border-radius: 20px; font-weight: bold; font-size: 13px; color: white; }
        .status-lulus { color: #27ae60; font-weight: bold; }
        .status-tidak-lulus { color: #e74c3c; font-weight: bold; }
        .footer { margin-top: 30px; padding-top: 20px; border-top: 2px solid #ecf0f1; text-align: center; color: #7f8c8d; font-size: 14px; }
    </style>
</head>
<body>
    <div class="container">