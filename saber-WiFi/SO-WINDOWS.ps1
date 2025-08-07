# Beny B. Reis II
# Mostrar todos os perfis Wi-Fi salvos e suas senhas
# 
# Só testei no SO Windows. no terminal, antes de executar este meu script, deve previamente fazer:
# 
#      PS C:\Windows\system32> Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#

$perfis = netsh wlan show profiles | Where-Object {
    $_ -match "All User Profile|Todos os perfis de usuário"
} | ForEach-Object {
    ($_ -split ":")[1].Trim()
}

if (-not $perfis) {
    Write-Host "Nenhum perfil Wi-Fi foi encontrado." -ForegroundColor Yellow
    exit
}

foreach ($perfil in $perfis) {
    Write-Host "`nVerificando perfil: $perfil"

    
    $detalhes = netsh wlan show profile name="$perfil" key=clear

    
    $linhaSenha = $detalhes | Select-String "Key Content|Conteúdo da chave"

    if ($linhaSenha) {
        $senha = ($linhaSenha -split ":")[1].Trim()
        Write-Host "Wi-Fi: $perfil"
        Write-Host "Senha: $senha" -ForegroundColor Green
    } else {
        Write-Host "Wi-Fi: $perfil - Senha não disponível ou protegida." -ForegroundColor Yellow
    }
}


Write-Output "`n `n (c) Beny B. Reis. All Rights Reserved`nOn Social Media `"@bybenb`" or `"@bkapa8`"`n`n"
Read-Host "Press Enter to END"