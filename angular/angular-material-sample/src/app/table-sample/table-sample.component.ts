import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';

export interface SampleElement {
    name: string;
    position: number;
    weight: number;
    symbol: string;
}

const ELEMENT_DATA: SampleElement[] = [
    {position: 1, name: 'AAAA', weight: 10, symbol: 'A'},
    {position: 2, name: 'BBBB', weight: 10, symbol: 'B'},
    {position: 3, name: 'CCCC', weight: 10, symbol: 'C'},
    {position: 4, name: 'DDDD', weight: 10, symbol: 'D'},
    {position: 5, name: 'EEEE', weight: 10, symbol: 'E'},
];

@Component({
  selector: 'app-table-sample',
  templateUrl: './table-sample.component.html',
  styleUrls: ['./table-sample.component.scss']
})
export class TableSampleComponent implements OnInit {
  displayedColumns: string[] = ['position','name','weight','symbol'];
  //dataSource = ELEMENT_DATA;
  dataSource = new MatTableDataSource(ELEMENT_DATA);

  constructor() { }

  ngOnInit(): void {
  }

}

