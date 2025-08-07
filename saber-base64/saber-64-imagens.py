import base64

def fuunc(a):
    with open(f"{a}", "rb") as image_file:
        base64_str = base64.b64encode(image_file.read()).decode('utf-8')
        data_uri = f"data:image/png;base64,{base64_str}"
        print(data_uri)

n = str(input("Nome completo da Imagem?\t[somente no diretório]\nR: "))
print("Codigo eh\n>>> ", end="")
fuunc(n)
input("Acabou. toce em qualquer botao: ")
