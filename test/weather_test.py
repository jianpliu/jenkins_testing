# -*- coding: utf-8 -*-
import allure

from unittest import TestCase
from library.httpClient import HttpClient

@allure.feature('Test Weather api')
class Weather(TestCase):
    def setUp(self):
        self.host='http://www.weather.com.cn'
        self.ep_path='/data/cityinfo'
        self.client=HttpClient()

    @allure.story('Test of Shenzhen')
    def test_1(self):
        city_code='101280601'
        exp_city='深圳'
        self._test(city_code,exp_city)

    @allure.story('Test of BeiJing')
    def test_2(self):
        city_code='101010100'
        exp_city='北京'
        self._test(city_code,exp_city)

    def _test(self,city_code,exp_city):
        url=f'{self.host}{self.ep_path}/{city_code}.html'
        response=self.client.Get(url=url)
        act_city=response.json()['weatherinfo']['city']
        print(f'Expect city={exp_city},while actual city={act_city}')
        self.assertEqual(exp_city,act_city,f'Expect city = {exp_city},while actual city={act_city}')


