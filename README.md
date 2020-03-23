# COVID-19 Estatísticas no Brasil

Esse aplicativo tem o intuito de ajudar todos a acompanhar as estatísticas do COVID-19 nos estados brasileiros e no Brasil como todo.

|                             |                             |                                 |                             |
| :-------------------------- | :-------------------------: | :-----------------------------: | :-------------------------: |
| ![01](./screenshots/01.png) | ![02](./screenshots/02.png) | ![03](./screenshots/03_map.png) | ![04](./screenshots/04.png) |
|                             |                             |                                 |                             |

## Nota!

Eu comecei a desenvolver esta aplicação de última hora enquanto me sentia bastante mal com suspeita de ter contraído o vírus e acabei adiando a ida ao hospital para publicar algo funcional e ajudar a todos. Mas no momento atual eu já fui ao hospital, tomei a devida medição e até agora foi constatado como descartado.

## Download

Você pode baixar os instaladores atráves das [releases](https://github.com/robsonsilv4/covid19_statistics/releases). Não se preocupe, pode instalar e compartilhar sem problemas, não há nada de malicioso e você pode conferir no código. Lançarei na Play Store assim que possível, no momento as informações são mais importantes.

## Como rodar o projeto

Primeiro você precisa clonar o repositório:

```sh
git clone https://github.com/robsonsilv4/covid19_statistics.git covid19_statistics
```

Agora basta entrar na pasta do projeto e baixar os pacotes:

```sh
cd covid19_statistics

flutter packages get
```

E rodar no seu dispositivo:

```sh
flutter run
```

## Como gerar o instalador

Para gerar os instaladores, basta entrar na pasta do projeto e rodar o seguinte comando:

```sh
flutter build apk --split-per-abi

flutter install # para instalar no dispositivo ou emulador
```

Os arquivos gerados ficam em:

```sh
covid19_statistics/build/app/outputs/apk/release/...
```

---

### Tecnologias e pacotes utilizados:

- [Dart](https://dart.dev/) como linguagem principal.
- [Flutter](https://flutter.dev/) como framework cross plataform.
- [Dio](https://github.com/flutterchina/dio) para requisição web.
- [MobX](https://github.com/mobxjs/mobx.dart) para gerenciamento de estado.
- [Flutter MobX](https://pub.dev/packages/flutter_mobx) para utilização do Observer junto aos widgets.
- [MobX Code Gen](https://pub.dev/packages/mobx_codegen) para geração dos stores.g.
- [Build Runner](https://github.com/dart-lang/build) para geração de código.
- [Find Dropdown](https://github.com/davidsdearaujo/find_dropdown) para seleção dos estados.

---

## Como contribuir

Você pode contribuir para o projeto de qualquer maneira. Seja instalado o aplicativo e dando feedback, abrindo issues, melhorando ou traduzindo a documentação, melhorando ou adicionando features, compartilhando ou falando sobre o projeto, doando ou de qualquer outra forma que conseguir. O importante é que essas informações cheguem a todos e que possamos passar por esse momento da melhor maneira possível.

---

## Contribuidores

<table>
  <tr>
    <td align="center">
        <a href="https://github.com/tlworkssoftware">
            <img src="https://avatars2.githubusercontent.com/u/43814721?s=400&u=50bcc428fea427bb7b95cd29b65cb052af0efa13&v=4" width="100px;" alt=""/>
            <br />
            <sub><b>tlworkssoftware</b></sub>
            <br />
            </a><a title="Code">💻</a>
            </a><a title="Design">🎨</a>
        </a>
    </td>
  <tr>
</table>

---

## Autor

<table>
  <tr>
    <td align="center">
        <a href="https://github.com/robsonsilv4">
            <img src="https://avatars0.githubusercontent.com/u/17673296?s=460&u=7ca64208ca0fd4658b62aa1808daeec688640f94&v=4" width="100px;" alt=""/>
            <br />
            <sub><b>Robson Silva</b></sub>
            <br />
            </a><a title="Code">💻</a>
            </a><a title="Design">🎨</a>
        </a>
    </td>
  <tr>
</table>

---

## Agredecimentos e créditos

Agredicimentos em especial e créditos ao [Arthur Ribeiro](https://github.com/devarthurribeiro), já que sem a [API](https://github.com/devarthurribeiro/covid19-brazil-api) disponiblizada por ele essa aplicação não seria possivel.

---

## Licença

A licença utilizado no projeto é a MIT. Para mais detalhes leia o [arquivo](./LICENSE.md).
