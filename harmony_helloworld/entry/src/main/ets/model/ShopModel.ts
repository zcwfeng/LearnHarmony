// import http from '@ohos.net.http';
import ShopInfo from '../viewmodel/ShopInfo';
import axios from '@ohos/axios'

class ShopModel {
  // baseURL: string = 'http://localhost:3000'
  baseURL: string = 'http://192.168.31.130:3000'
  pageNo: number = 1


  getShopList(): Promise<ShopInfo[]> {

    return new Promise((resolve, reject) => {

      axios.get(
        `${this.baseURL}/shops`,
        {
          params: { pageNo: this.pageNo, pageSize: 4 }
        }
      )
        .then(
          resp => {
            if (resp.status === 200) {
              console.log('查询商铺Success' + JSON.stringify(resp.data));

              resolve(resp.data)
            } else {
              console.log('查询商铺失败1，error ：', JSON.stringify(resp));
              reject('查询商铺失败1')
            }
          }
        ).catch(
        error => {
          console.log('查询商铺失败2，error ：', JSON.stringify(error));
          reject('查询商铺失败2')
        }
      )
    })
  }


  /*getShopList(): Promise<ShopInfo[]> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseURL}/shops?pageNo=${this.pageNo}&pageSize=4`,
        {
          method: http.RequestMethod.GET
        }
      )
        .then(
          resp => {
            if (resp.responseCode === 200) {
              console.log('查询商铺Success' + resp.result.toString());

              resolve(JSON.parse(resp.result.toString()))
            } else {
              console.log('查询商铺失败1，error ：', JSON.stringify(resp));
              reject('查询商铺失败1')
            }
          }
        ).catch(
        error => {
          console.log('查询商铺失败2，error ：', JSON.stringify(error));
          reject('查询商铺失败2')
        }
      )
    })
  }*/
}

const shopModel = new ShopModel()

export default shopModel as ShopModel