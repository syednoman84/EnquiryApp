/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.ezeon.poc.repo;

import net.ezeon.poc.domain.EnquiryCourse;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author Vikram
 */
public interface EnquiryCourseRepository extends JpaRepository<EnquiryCourse, Long> {
    
}
