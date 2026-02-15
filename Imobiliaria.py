from colorama import Fore, init
import os
import csv

init(autoreset=True)

def validar_opcao(mensagem, opcoes_validas):
    while True:
        resposta = input(mensagem).strip().upper()
        if resposta in opcoes_validas:
            return resposta
        else:
            print(f"{Fore.RED} Opção inválida! Escolha uma das opções: {', '.join(opcoes_validas)}")


def validar_numero(mensagem, minimo=None):
    while True:
        try:
            numero = int(input(mensagem))
            if minimo is not None and numero < minimo:
                print(f"{Fore.RED} O número deve ser no mínimo {minimo}.")
                continue
            return numero
        except ValueError:
            print(f"{Fore.RED} Digite apenas números válidos!")

print(f"{Fore.GREEN}Olá, seja bem  vindo a R.M!!! Poderia me informar que tipo de imóvel está procurando?")
print(f"{Fore.GREEN}1 - Casas")
print(f"{Fore.GREEN}2 - Apartamentos")
print(f"{Fore.GREEN}3 - Estudios")
opcao = validar_opcao(
    f"{Fore.GREEN} Escolha uma opção (1/2/3): ",
    ["1", "2", "3"])

if opcao == "1":
    aluguel = 900.00
    total = aluguel
    
    print(f"{Fore.GREEN} Você procura casas com 1 ou 2 quartos para alugar?")  
    quartos = validar_opcao(
        f"{Fore.BLUE} Informe a quantidade de quartos (1 ou 2): ",
        ["1", "2"])

    print(f"{Fore.GREEN} Deseja incluir uma vaga de garagem?")
    print(f"{Fore.GREEN} S - SIM")
    print(f"{Fore.GREEN} N - NÃO")
    vaga = validar_opcao(
        f"{Fore.BLUE} Deseja vaga? (S/N): ",
        ["S", "N"])

    if vaga == "S":
        total += 300.00

    if quartos == "2":
        total += 250.00
    
    

if opcao == "2":
    aluguel = 700.00
    total = aluguel 
    
    print(f"{Fore.GREEN} Você procura apartamentos com 1 ou 2 quartos para alugar?")  
    quartos = validar_opcao(
        f"{Fore.BLUE} Informe a quantidade de quartos (1 ou 2): ",
        ["1", "2"])

    print(f"{Fore.GREEN} Deseja incluir uma vaga de garagem?")
    print(f"{Fore.GREEN} S - SIM")
    print(f"{Fore.GREEN} N - NÃO")
    
    vaga = validar_opcao(
    f"{Fore.BLUE} Deseja vaga? (S/N): ",
    ["S", "N"])

    if vaga == "S":
        total += 300.00
    
    if quartos == "2":
        total += 200.00
    
    

if opcao == "3":
    aluguel = 1200.00

    vaga = validar_opcao(
    f"{Fore.BLUE} Deseja vaga? (S/N): ",
    ["S", "N"])

    if vaga == "S":
    
        garagem = validar_numero(
            f"{Fore.BLUE} Informe o número de vagas que deseja: ",
            minimo=2)
        
        if garagem == 2:
            total = aluguel + 250.00

        elif garagem > 2:
            extra = (garagem - 2) * 60.00
            total = aluguel + 250.00 + extra


    elif vaga == "N":

        total = aluguel

print(f"{Fore.GREEN} Você possui crianças?")
print(f"{Fore.GREEN} S - SIM")
print(f"{Fore.GREEN} N - NÃO")
criancas = input(f"{Fore.BLUE}: ").upper()

if criancas == "N":
    desconto = total * 0.05
    total = total - desconto
    print(f"{Fore.GREEN} Desconto de 5% aplicado!")
else:
    desconto = 0

contrato = 2000.00
parcelas_contrato = 5
valor_parcela_contrato = contrato / parcelas_contrato

parcelas_aluguel = 12
valor_parcela_aluguel = total
valor_total_anual = total * parcelas_aluguel

print("\n")
print(f"{Fore.GREEN}========== RESUMO FINAL ==========")
print(f"{Fore.GREEN}Valor mensal do aluguel: R$ {total:.2f}")
print(f"{Fore.GREEN}Valor anual do aluguel: R$ {valor_total_anual:.2f}")
print(f"{Fore.GREEN}Valor total do contrato: R$ {contrato:.2f}")
print(f"{Fore.GREEN}Desconto aplicado: R$ {desconto:.2f}")
print(f"{Fore.GREEN}==================================")
    
with open("C:/Users/Dell/Desktop/contrato.csv", "w", newline="", encoding="utf-8") as arquivo:
    writer = csv.writer(arquivo, delimiter=";")

    writer.writerow(["==============================================="])
    writer.writerow(["            CONTRATO DE LOCACAO R.M            "])
    writer.writerow(["==============================================="])
    writer.writerow([])

    writer.writerow(["DADOS DO CONTRATO"])
    writer.writerow(["Valor Total do Contrato", f"R$ {contrato:.2f}"])
    writer.writerow(["Parcelas do Contrato", parcelas_contrato])
    writer.writerow(["Valor de Cada Parcela", f"R$ {valor_parcela_contrato:.2f}"])
    writer.writerow([])

    writer.writerow(["-----------------------------------------------"])
    writer.writerow(["DETALHES DO ALUGUEL"])
    writer.writerow(["Valor Mensal", f"R$ {total:.2f}"])
    writer.writerow(["Valor Total Anual", f"R$ {valor_total_anual:.2f}"])
    writer.writerow(["Possui Crianças?", "SIM" if criancas == "S" else "NÃO"])
    writer.writerow(["Desconto Aplicado (5%)", f"R$ {desconto:.2f}"])
    writer.writerow([])

    writer.writerow(["-----------------------------------------------"])
    writer.writerow(["CRONOGRAMA DE PAGAMENTO - CONTRATO"])
    writer.writerow(["Parcela", "Valor"])

    for i in range(1, parcelas_contrato + 1):
        writer.writerow([i, f"R$ {valor_parcela_contrato:.2f}"])

    writer.writerow([])
    writer.writerow(["-----------------------------------------------"])
    writer.writerow(["CRONOGRAMA DE PAGAMENTO - ALUGUEL"])
    writer.writerow(["Mes", "Valor"])

    for i in range(1, parcelas_aluguel + 1):
        writer.writerow([i, f"R$ {valor_parcela_aluguel:.2f}"])

    writer.writerow([])
    writer.writerow(["==============================================="])

print(f"{Fore.GREEN} Contrato salvo com sucesso!")