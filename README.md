# NearbyMe - Aplicativo Móvel Swift Nativo para IOS com consumo de API
O NearbyMe é um aplicativo que concome uma API de locais parceiros, a qual fornece localização, informações sobre o local (nome do estabelecimento, descrição, telefone) e cupons de desconto.  

## Tecnologias utilizadas:
* Swift
* UIKit
* MapKit
* Foundation
* Cocoapods

## Padrões de Projeto: 
* MVVM-C: Model View ViewModel Coordinator
* ViewCode: sem uso de StoryBoard ou SwiftUI

### Para executar o projeto:
* O projeto foi desenvolvido no XCode 16
* É necessário ambiente MacOS com Emulador de IOS
* Para executar no Iphone, é necessário habilitar o modo desenvolvedor e confiar o disposito e desenvolvedor (Settings -> General -> VPN and Devices)
* Para que o App funcione no Iphone é necessário aceitar as permissões de rede
* A api precisa ser executada separadamente para que os dados sejam consumidos pelo app

### Melhorias
- Implementar a funcionalidade de leitura de QRCodes
- Ajustar layout da lista de lugares disponíveis na tela Home
- Ajustar ícones da tela de detalhes do local

## Links úteis:
- [Figma](https://www.figma.com/design/ZBwCdDS0H0aBpc1XHigNmX/NLW-Pocket-Mobile-%E2%80%A2-Nearby-(Community)?node-id=3111-321&node-type=frame&t=HQ7HIUNiE53Qkwzy-0)
- [Guia](https://docs-rocketseat.notion.site/Swift-iOS-149395da577081cdb133ef1ec3fb02c5#149395da577080439264d7bf001373bb)
